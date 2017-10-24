/* Instruction Memory Module
Allows reading of the instructions for the program.
*/
module instr_memory (
	input [31:0] ByteAddress,
	input [31:0] StrPrintAddr,

	output reg [31:0] Instruction,
	output [31:0] StrPrint
);

`define INSTRUCTION_MEM_UPPER 32'h00101000
`define INSTRUCTION_MEM_LOWER 32'h00100000

// Needed to switch upper and lower order because of $readmemh
reg [31:0] memory [`INSTRUCTION_MEM_LOWER:`INSTRUCTION_MEM_UPPER];

// Reads in the Instructions into memory
initial begin
	$readmemh(`PROGRAM_NAME, memory);
end

always @ (ByteAddress) begin
	Instruction = memory[ByteAddress >> 2];
end

/* This is for a string print syscall, we always want to be passing
the value stored in instruction memory at the address that starts at
a0 (but changes). Whether we use the value is handled in syscall.
*/
assign StrPrint = memory[StrPrintAddr >> 2];

endmodule
