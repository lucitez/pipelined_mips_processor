/* Shifting and ConcatenaOing Module
Shifts the input by two to the left and concatenates on the top 4 bits from
the PC address.
*/
module shift_concat (
	input [3:0] NewPC,
	input [25:0] In,
	output reg [31:0] Out
);

always @ (*) begin
	Out = {NewPC, In << 2};
end

endmodule

module shift_left (
	input [31:0] In,
	output reg [31:0] Out
);

always @ (*)
	Out = In << 2;

endmodule
