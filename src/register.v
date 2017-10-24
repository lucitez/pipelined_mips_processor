/* Registers Module
Holds all of the registers for the cpu. Allows reading of two registers
and writing one register. The reading occurs on the positive clk edge
and writing on the negative clk edge so that an instruction can read and
write in one clk cycle.
*/
module register (
	input clk,
	input RegWrite,
	input [4:0] ReadReg1,
	input [4:0] ReadReg2,
	input [4:0] WriteReg,
	input [31:0] WriteData,
	input Jal,
	input [31:0] JalAddr,
	output reg [31:0] ReadData1,
	output reg [31:0] ReadData2,
	output wire [31:0] A0,
	output wire [31:0] V0
);

reg [31:0] registers [31:0];
reg [31:0] test;

// Internal helper variables
wire outreg;
integer i;

// Initializes all variables to 0
initial begin
	for (i=0; i<32; i=i+1) begin
		registers[i] <= 0;
	end

	registers[`sp] <= 32'h7ffffffc;
end

// Reading
always @ (negedge clk) begin
	ReadData1 <= registers[ReadReg1];
	ReadData2 <= registers[ReadReg2];
end

// Writing
always @ (posedge clk) begin
	if (RegWrite) begin
		registers[WriteReg] <= WriteData;
	end
	if (Jal) begin
		registers[`ra] <= JalAddr;
	end
end

assign A0 = registers [`a0];
assign V0 = registers [`v0];

endmodule
