/* Memory Register Module
This module handles the passing of data between the execute and memory phase
Passes through all relevant control signals and data signals.
*/

module mem_reg (
	input clk,
	// Controller logic inputs
	input RegWriteE, input MemtoRegE, input MemWriteE, input SyscallE,

	// Data inputs
	input wire [31:0] ALUOutE, input wire [31:0] WriteDataE, input wire [4:0] WriteRegE,

	// Controller logic Outputs
	output reg RegWriteM, output reg MemtoRegM, output reg MemWriteM, output reg SyscallM,

	// Data outputs
	output reg [31:0] ALUOutM, output reg [31:0] WriteDataM, output reg [4:0] WriteRegM
);

reg [8*8:1] string_value;

always @(posedge clk) begin
	RegWriteM <= RegWriteE;
	MemtoRegM <= MemtoRegE;
	MemWriteM <= MemWriteE;
	SyscallM <= SyscallE;

	ALUOutM <= ALUOutE;
	WriteDataM <= WriteDataE;
	WriteRegM <= WriteRegE;
end

endmodule
