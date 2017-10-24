/*
* Module to test the functionality of the mux module
*/
module mux_test();

`define ASSERTIFY assertify = 1; assertify = 0; #5;

reg assertify = 0;

reg [31:0] ifZero;
reg [31:0] ifOne;
reg [31:0] ifTwo;
reg control1Bit;
reg [1:0] control2Bit;

wire [31:0] actualOut1Bit;
reg [31:0] expectedOut1Bit;

wire [31:0] actualOut2Bit;
reg [31:0] expectedOut2Bit;


initial begin

	//one bit mux test
	//control = 0
	$display("\nTesting 1bit control muxer");
	ifZero = 0;
	ifOne = 1;
	control1Bit = 1; 
	expectedOut1Bit = ifOne; #5;
	$display("Testing - control %x - ifZero %x - ifOne %x - [actualOut: %x - expectedOut: %x]", control1Bit, ifZero, ifOne, actualOut1Bit, expectedOut1Bit);
	`ASSERTIFY

	//control = 1
	ifZero = 0;
	ifOne = 1;
	control1Bit = 0; 
	expectedOut1Bit = ifZero; #5;
	$display("Testing - control %x - ifZero %x - ifOne %x - [actualOut: %x - expectedOut: %x]", control1Bit, ifZero, ifOne, actualOut1Bit, expectedOut1Bit);
	`ASSERTIFY


	//two bit mux test
	//control = 00
	$display("\nTesting 2bit control muxer");
	ifZero = 0;
	ifOne = 1;
	ifTwo = 2;
	control2Bit = 0; 
	expectedOut2Bit = ifZero; #5;
	$display("Testing - control %x - ifZero %x - ifOne %x, ifTwo %x - [actualOut: %x - expectedOut: %x]", control2Bit, ifZero, ifOne, ifTwo, actualOut2Bit, expectedOut2Bit);
	`ASSERTIFY

	//control = 01
	ifZero = 0;
	ifOne = 1;
	ifTwo = 2;
	control2Bit = 1; 
	expectedOut2Bit = ifOne; #5;
	$display("Testing - control %x - ifZero %x - ifOne %x, ifTwo %x - [actualOut: %x - expectedOut: %x]", control2Bit, ifZero, ifOne, ifTwo, actualOut2Bit, expectedOut2Bit);
	`ASSERTIFY

	//control = 10
	ifZero = 0;
	ifOne = 1;
	ifTwo = 2;
	control2Bit = 2; 
	expectedOut2Bit = ifTwo; #5;
	$display("Testing - control %x - ifZero %x - ifOne %x, ifTwo %x - [actualOut: %x - expectedOut: %x]", control2Bit, ifZero, ifOne, ifTwo, actualOut2Bit, expectedOut2Bit);
	`ASSERTIFY

	//control = 11
	ifZero = 0;
	ifOne = 1;
	ifTwo = 2;
	control2Bit = 3; 
	expectedOut2Bit = ifTwo; #5;
	$display("Testing - control %x - ifZero %x - ifOne %x, ifTwo %x - [actualOut: %x - expectedOut: %x]", control2Bit, ifZero, ifOne, ifTwo, actualOut2Bit, expectedOut2Bit);
	`ASSERTIFY



end

mux_1bit #(.BITS(31)) mux1bit(control1Bit, ifZero, ifOne, actualOut1Bit);
mux_2bit #(.BITS(31)) mux2bit(control2Bit, ifZero, ifOne, ifTwo, actualOut2Bit);

assert #(.BITS(32))  assertOut1Bit(
	actualOut1Bit,
	expectedOut1Bit,
	assertify,
	"AdderOutTest"
);

assert #(.BITS(32))  assertOut2Bit(
	actualOut2Bit,
	expectedOut2Bit,
	assertify,
	"AdderOutTest"
);

endmodule
