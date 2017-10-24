/*
* Module to test the functionality of the mux module
*/
module alu_test();

`define ASSERTIFY assertify = 1; assertify = 0; #5;

reg assertify = 0;

reg [3:0] aluOp;
reg [31:0] in1;
reg [31:0] in2;

wire [31:0] actualOut;
reg [31:0] expectedOut;


initial begin

	//test alu add
	$display("\nTesting ALU_ADD");
	in1 = 5;
	in2 = 10;
	aluOp = `ALU_ADD;
	expectedOut = in1 + in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 9;
	in2 = -9;
	aluOp = `ALU_ADD;
	expectedOut = in1 + in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	//test alu sub
	$display("\nTesting ALU_SUB");
	in1 = 5;
	in2 = 10;
	aluOp = `ALU_SUB;
	expectedOut = in1 - in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 9;
	in2 = -9;
	aluOp = `ALU_SUB;
	expectedOut = in1 - in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	//test alu and
	$display("\nTesting ALU_AND");
	in1 = 1;
	in2 = 1;
	aluOp = `ALU_AND;
	expectedOut = in1 & in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 0;
	in2 = 1;
	aluOp = `ALU_AND;
	expectedOut = in1 & in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	//test alu or
	$display("\nTesting ALU_OR");
	in1 = 1;
	in2 = 1;
	aluOp = `ALU_OR;
	expectedOut = in1 | in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 0;
	in2 = 1;
	aluOp = `ALU_OR;
	expectedOut = in1 | in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 0;
	in2 = 0;
	aluOp = `ALU_OR;
	expectedOut = in1 | in2; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	//test alu slt
	$display("\nTesting ALU_SLT");
	in1 = 0;
	in2 = 1;
	aluOp = `ALU_SLT;
	expectedOut = in1 < in2 ? 1 : 0; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 1;
	in2 = 0;
	aluOp = `ALU_SLT;
	expectedOut = in1 < in2 ? 1 : 0; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]", in1, in2, actualOut, expectedOut);
	`ASSERTIFY

	in1 = 0;
	in2 = 0;
	aluOp = `ALU_SLT;
	expectedOut = in1 < in2 ? 1 : 0; #5;
	$display("Testing - input1 %x - input2 %x - [actualOut: %x - expectedOut: %x]\n", in1, in2, actualOut, expectedOut);
	`ASSERTIFY


end

alu aluTester(aluOp, in1, in2, actualOut);

assert #(.BITS(32))  assertOut(
	actualOut,
	expectedOut,
	assertify,
	"AdderOutTest"
);

endmodule
