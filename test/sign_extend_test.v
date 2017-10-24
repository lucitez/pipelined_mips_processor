/*
* Module to test the functionality of the mux module
*/
module sign_extend_test();

`define ASSERTIFY assertify = 1; assertify = 0; #5;

reg assertify = 0;

reg [15:0] in;

wire [31:0] actualOut;
reg [31:0] expectedOut;


initial begin

	//test sign_extend
	$display("\nTesting signExtend 16bit -> 32bit");
	in = 5;
	expectedOut = 32'd5; #5;
	$display("Testing - 16bitInput %x - [actualOut: %x - expectedOut: %x]", in, actualOut, expectedOut);
	`ASSERTIFY

	in = 10000;
	expectedOut = 32'd10000; #5;
	$display("Testing - 16bitInput %x - [actualOut: %x - expectedOut: %x]", in, actualOut, expectedOut);
	`ASSERTIFY

	in = -5;
	expectedOut = 32'hfffffffb; #5;
	$display("Testing - 16bitInput %x - [actualOut: %x - expectedOut: %x]", in, actualOut, expectedOut);
	`ASSERTIFY


end

sign_extend extender(in, actualOut);

assert #(.BITS(32))  assertOut(
	actualOut,
	expectedOut,
	assertify,
	"AdderOutTest"
);

endmodule
