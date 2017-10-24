/*
* Module to test the functionality of the adder module
*/
`define PROGRAM_START 32'h00400020
`define PROGRAM_NAME "../programs/add_test.v"

module instr_memory_test();

`define ASSERTIFY assertify = 1; assertify = 0; #5;

reg assertify = 0;

reg [31:0] byte_addr;
wire [31:0] instr;

reg [31:0] print_str_addr;
wire [31:0] print_str;

reg [31:0] exp_instr;

initial begin
	byte_addr = 32'h00400020;
	#5;
	$display("Testing - byte addr: %x - instr: %x", byte_addr, instr);

	exp_instr = 32'h24080001;
	`ASSERTIFY

	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h24090002;
	`ASSERTIFY

	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h24020001;
	`ASSERTIFY

	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h01292020;
	`ASSERTIFY

	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h0000000C;
	`ASSERTIFY

	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h2402000A;
	`ASSERTIFY

	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h00000000;
	`ASSERTIFY
	
	byte_addr = byte_addr + 4;
	#5;
	exp_instr = 32'h0000000C;
	`ASSERTIFY

end

instr_memory instr_mem(byte_addr, print_str_addr, instr, print_str);


assert #(.BITS(32))  assert_instr_mem(
	instr,
	exp_instr,
	assertify,
	"InstrMemTest"
);

endmodule
