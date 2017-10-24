/* Writeback Reg Module
This module handles the register memory between the memory and writeback phase
Passes through all relevant control signals and data signals.
*/

module writeback_reg(
	input clk,
	//Controller logic inputs
	input RegWriteM, input MemtoRegM, input SyscallM,

	//Data inputs
	input wire [31:0] ReadDataM, input wire [31:0] ALUOutM, input wire [4:0] WriteRegM,

	//Controller logic Outputs
	output reg RegWriteW, output reg MemtoRegW, output reg SyscallW,

	//Data outputs
	output reg [31:0] ReadDataW, output reg [31:0] ALUOutW, output reg [4:0] WriteRegW
);

always @(posedge clk) begin
	RegWriteW <= RegWriteM;
	MemtoRegW <= MemtoRegM;
	SyscallW <= SyscallM;

	ReadDataW <= ReadDataM;
	ALUOutW <= ALUOutM;
	WriteRegW <= WriteRegM;
end

endmodule
