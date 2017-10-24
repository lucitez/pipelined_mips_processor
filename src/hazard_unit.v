/* Hazard Unit Module
Detect hazards and route forwards
*/
`define is_i_type 3'b100
`define is_r_type 3'b010
`define is_j_type 3'b001

module hazard_unit(
	input clk,

	// DC = Decode
	input [2:0] DC_irj, input [4:0] DC_rs, input [4:0] DC_rt, input [4:0] DC_rd, input [31:0] DC_instr,

	// Control inputs
	input BranchD, input MemtoRegE, input RegWriteE, input MemtoRegM, input RegWriteM, input RegWriteW,

	// Control outputs
	output reg StallF,
	output reg StallD,
	output reg ForwardAD,
	output reg ForwardBD,
	output reg FlushE,
	output reg [1:0] ForwardAE,
	output reg [1:0] ForwardBE,
	output reg ForwardMM
);

// Holds all prior instructions for passing through the line
// EX: Execute; ME: Memory; WB: Writeback
reg stallRes, branchStallRes, branchHazard;
reg [4:0] EX_rd, ME_rd, WB_rd; // rd register from the instruction
reg [4:0] EX_rs, ME_rs, WB_rs; // rs register from the instruction
reg [4:0] EX_rt, ME_rt, WB_rt; // rt register from the instruction
reg [2:0] EX_irj, ME_irj, WB_irj; // whether each instruction stage is an i, r, or j type
reg [31:0] EX_instr, ME_instr, WB_instr;
reg [4:0] resultD, resultE, resultM, resultW;
// Use the above information and the below logic to detect and route hazards

// Don't want to stall the pipeline in the first cycle
initial begin
	StallF <= 1'b0;
	StallD <= 1'b0;
	ForwardAD <= 1'b0;
	ForwardBD <= 1'b0;
	FlushE <= 1'b0;
	ForwardAE <= 2'b00;
	ForwardBE <= 2'b00;
	ForwardMM <= 0;
end

// Handles StallF, StallD, FlushE
always @ (*) begin
	if (DC_irj == `is_r_type) begin
		resultD <= DC_rd;
	end else if (DC_irj == `is_i_type) begin
		resultD <= DC_rt;
	end

	// Stall based on dependencies for i types and following operations, focused on when register is getting a value from mem
	ForwardAD = (DC_rs != 0) && (DC_rs == resultM) && (RegWriteM);
	ForwardBD = (DC_rt != 0) && (DC_rt == resultM) && (RegWriteM);
	stallRes = (((DC_rs == EX_rt) || (DC_rt == EX_rt)) && MemtoRegE);
	branchHazard = (BranchD && ((DC_rt == EX_rd) || DC_rt == ME_rd || DC_rt == WB_rd));
	branchStallRes = ((BranchD && RegWriteE) && ((RegWriteE == DC_rs) || (RegWriteE == DC_rt))) || ((BranchD && MemtoRegM) && ((RegWriteM == DC_rs) || (RegWriteM == DC_rt)));

	StallD = stallRes || branchStallRes || branchHazard;
	StallF = stallRes || branchStallRes;
	FlushE = stallRes || branchStallRes;
end

always @ (*) begin

	/* EX->EX, MEM->EX forward
	Check for dependencies where the new instruction needs the result of a
	previous alteration of a register that hasnt been written back yet
	*/
	if ((EX_rs != 4'b0) && (EX_rs == resultM) && RegWriteM) begin
		ForwardAE <= 2'b10;
	end else if ((EX_rs != 4'b0) && (EX_rs == resultW) && RegWriteW) begin
		ForwardAE <= 2'b01;
	end else begin
		ForwardAE <= 2'b00;
	end
	if ((EX_rt != 4'b0) && (EX_rt == resultM) && RegWriteM) begin
		ForwardBE <= 2'b10;
	end else if ((EX_rt != 4'b0) && (EX_rt == resultW) && RegWriteW) begin
		ForwardBE <= 2'b01;
	end else begin
		ForwardBE <= 2'b00;
	end

	FlushE = (DC_instr[5:0] == `JR ? 1 :0 );

	/* MEM->MEM forward
	store word instruction immediately following an instruction that modifies what store word needs
	li-sw, add-sw, and-sw, etc... so it includes both r and i types
	*/
	if (ME_instr[31:26] == `SW) begin // Is MEM doing a storeword?
		if (WB_irj == `is_r_type) begin
			if (ME_rt == WB_rd) begin // SW needs the R types result, do MEM->MEM
				ForwardMM = 1;
			end else begin
				ForwardMM = 0;
			end
		end else if (WB_irj == `is_i_type) begin
			if (ME_rt == WB_rt) begin // SW needs the I types result, do MEM->MEM
				ForwardMM = 1;
			end else begin
				ForwardMM = 0;
			end
		end
	end else begin
		ForwardMM = 0;
	end
end

always @(posedge clk) begin
	// Pass Decode to Execute, Execute to Mem, Mem to Writeback with the clock.
	// This ensures synchronicity with the rest of the pipeline.
	if (!StallD) begin
		EX_rd <= DC_rd;
		EX_rs <= DC_rs;
		EX_rt <= DC_rt;
		EX_irj <= DC_irj;
		EX_instr <= DC_instr;
		resultE <= resultD;
	end else begin // Execute is unique, must look out for a stalled Decode stage
		EX_rd <= 5'b00000;
		EX_rs <= 5'b00000;
		EX_rt <= 5'b00000;
		EX_irj <= 3'b000;
		EX_instr <= 32'h00000000;
		resultE <= 5'b00000;
	end
	ME_rd <= EX_rd;
	ME_rt <= EX_rt;
	ME_rs <= EX_rs;
	ME_irj <= EX_irj;
	ME_instr <= EX_instr;
	resultM <= resultE;

	WB_rd <= ME_rd;
	WB_rt <= ME_rt;
	WB_rs <= ME_rs;
	WB_irj <= ME_irj;
	resultW <= resultM;
end

endmodule
