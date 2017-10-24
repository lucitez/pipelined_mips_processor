/* Adder Module
 * Adds 4 to the input and puts that in the output.  Can be overriden to add
 * any value to the input.
 */

module adder (
	 input [31:0] InOne,
	 input [31:0] InTwo,
	 output [31:0] Out
);

assign Out = InOne + InTwo;

endmodule

module plusFourAdder(
	input [31:0] In,
	output [31:0] Out
);

parameter [31:0] inc = 4;

assign Out = In + inc;

endmodule
