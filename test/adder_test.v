/*
* Module to test the functionality of the adder module
*/
module adder_test();

`define ASSERTIFY assertify = 1; assertify = 0; #5;

reg assertify = 0;

reg [31:0] in_reg;
wire [31:0] out_reg;

reg [31:0] in_five;
wire [31:0] out_five;

reg [31:0] exp_out;
reg [31:0] exp_out_five;

initial begin
	in_reg = 3; //addi $t1 $t2 0x9
	#5;
	$display("Testing - in %x - out: %x", in_reg, out_reg);
	//I type
	exp_out = 7;
	`ASSERTIFY

	// --------------------------------------------------
	in_reg = 32'hffffffff; //add $t0 $t1 $t2
	#5;
	$display("Testing - in %x - out: %x", in_reg, out_reg);

	exp_out = 3;
	`ASSERTIFY;

	// --------------------------------------------------
	in_five = 3;
	#5;
	$display("Testing - in %x - out: %x", in_five, out_five);

	exp_out_five = 8;
	`ASSERTIFY;
	
	// --------------------------------------------------
	in_five = 32'hffffffff;
	#5;
	$display("Testing - in %x - out: %x", in_five, out_five);

	exp_out_five = 4;
	`ASSERTIFY;

end

plusFourAdder addr_reg(in_reg, out_reg);

plusFourAdder #(.inc(5)) addr_five(in_five, out_five);

assert #(.BITS(32))  assert_out(
	out_reg,
	exp_out,
	assertify,
	"AdderOutTest"
);

assert #(.BITS(32))  assert_out_five(
	out_five,
	exp_out_five,
	assertify,
	"AdderOutTest"
);

// always @(*) begin
// 	$monitor("Properties - irj: %x - rs: %x - rt: %x - rd: %x", irj, rs, rt, rd);
// end

endmodule
