/* Execute Register
This module handles the register memory between the decode and execute phase
Passes through all relevant control signals and data signals.
Flushes the system if flush is called, so that no changes to the system are made (NO OP)
*/

module execute_reg (	//Reg control inputs
	input clk, input FlushE,
	//Controller logic inputs
	input RegWriteD, input MemtoRegD, input MemWriteD, input [3:0] ALUControlD, input wire ALUSrcD, input RegDstD, input syscallD,

	//Data inputs
	input wire [4:0] RsD, input wire [4:0] RtD, input wire [4:0] RdD, input wire [31:0] SignImmD, input wire [31:0] Rd1D, input wire [31:0] Rd2D,

	//Controller logic Outputs
	output reg RegWriteE, output reg MemtoRegE, output reg MemWriteE, output reg [3:0] ALUControlE, output reg ALUSrcE, output reg RegDstE, output reg syscallE,

	//Data outputs
	output reg [4:0] RsE, output reg [4:0] RtE, output reg [4:0] RdE, output reg [31:0] SignImmE, output reg [31:0] Rd1E, output reg [31:0] Rd2E
);

always @(posedge clk) begin
	// $strobe("RdD: %x, RtD: %x, RsD: %x", RdD, RtD, RsD);
	if(!FlushE) begin
		RegWriteE <= RegWriteD;
		MemtoRegE <= MemtoRegD;
		MemWriteE <= MemWriteD;
		ALUControlE <= ALUControlD;
		ALUSrcE <= ALUSrcD;
		RegDstE <= RegDstD;
		syscallE <= syscallD;

		RsE <= RsD;
		RtE <= RtD;
		RdE <= RdD;
		SignImmE <= SignImmD;
		Rd1E <= Rd1D;
		Rd2E <= Rd2D;
	end else begin // Flush all signals
		RegWriteE <= 0;
		MemtoRegE <= 0;
		MemWriteE <= 0;
		ALUControlE <= 0;
		ALUSrcE <= 0;
		RegDstE <= 0;
		syscallE <= 0;

		RsE <= 0;
		RtE <= 0;
		RdE <= 0;
		SignImmE <= 0;
		Rd1E <= 0;
		Rd2E <= 0;
	end
end

endmodule
