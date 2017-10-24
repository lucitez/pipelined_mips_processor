/* Data Memory Module
Similar to the register modules, takes in a control signal to
determine whether to write to data memory.  The address input is
the memory location to either read or write on. Always read data.
If memWrite is HIGH, then WriteData is saved in the address specified.
*/

// hard coded limits to the memory
`define STACK_UPPER_LIMIT 32'h7fffffff
`define STACK_LOWER_LIMIT 32'h7ffffeff

module data_memory (
	input MemWrite,
	input [31:0] Address,
	input [31:0] WriteData,
	output reg [31:0] ReadData
);

reg [31:0] data [`STACK_UPPER_LIMIT:`STACK_LOWER_LIMIT]; // can't initialize data, don't assume it's anything

always @ (*) begin
	ReadData <= data [Address]; // want to read data no matter what.

	if (MemWrite) begin
		data [Address] <= WriteData;
	end
end

endmodule
