/* 2Bit Mux Module
This is a universal mux (any number of bits). If test is zero Ifzero is returned. If test is one ifOne is returned. Output is Out. This verison has a 2bit Control.
*/
module mux_2bit (
	input wire [1:0] Control,
	input wire [BITS:0] IfZero,
	input wire [BITS:0] IfOne,
	input wire [BITS:0] IfTwo,
	output reg [BITS:0] Out
);

parameter BITS = 31;

always @ (*) begin
	Out = (Control[1] == 1 ? IfTwo : (Control[0] == 1 ? IfOne : IfZero)); // Terinary operator to determine Output of mux.
end

endmodule
