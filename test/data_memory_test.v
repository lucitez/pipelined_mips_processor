/*
* Module to test the functionality of the data_memory
*/
module data_memory_test();

`define ASSERTIFY assertify = 1; assertify = 0; #5;
`define FILE "../programs/add_test.v"

reg assertify = 0;


reg memWrite;
reg [31:0] address;
reg [31:0] writeData;
wire [31:0] readData;

reg [31:0] expReadData;

integer dataVal;

initial begin

	memWrite = 1;	
	address = 32'h7fffffe0;
	writeData = 5; #5
	$display("Writing %x to address %x",writeData,address);

	memWrite = 0; 
	expReadData = 5; #5
	$display("Reading %x from address %x (expected %x)\n", readData, address, expReadData);
	`ASSERTIFY

	memWrite = 1;	
	address = 32'h7ffffff0;
	writeData = -49543; #5
	$display("Writing %x to address %x",writeData,address);

	memWrite = 0; 
	expReadData = -49543; #5
	$display("Reading %x from address %x (expected %x)\n", readData, address, expReadData);
	`ASSERTIFY

	memWrite = 1;	
	address = 32'h7fffffa0;
	writeData = 18; #5
	$display("Writing %x to address %x",writeData,address);

	memWrite = 0; 
	expReadData = 18; #5
	$display("Reading %x from address %x (expected %x)\n", readData, address, expReadData);
	`ASSERTIFY

end

data_memory dataMem(memWrite,address, writeData, readData);

assert #(.BITS(32))  assert_instr_mem(
	readData,
	expReadData,
	assertify,
	"InstrMemTest"
);

endmodule
