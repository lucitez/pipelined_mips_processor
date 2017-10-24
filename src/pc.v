/* Program Counter Module
Temporarily stores the current instruction to be executed.  Changes on the
negative edge of the clock.
*/
module pc (
	input clock,
	input [31:0] in,
	output reg [31:0] out
);

initial begin
	// program start (skipping header)
	out = 32'h00400020;
end

always @ (posedge clock) begin
	out = in;
end

endmodule
