/* 1Bit Mux Module
This is a universal mux (any number of bits). If test is zero Ifzero is returned. If test is one ifOne is returned. Output is out.
*/
module mux_1bit (
  input wire Control,
  input wire [BITS:0] IfZero,
  input wire [BITS:0] IfOne,
  output reg [BITS:0] Out
);

parameter BITS = 31;

always @ (*) begin
  Out = (Control == 0) ? IfZero : IfOne; //terinary operator to determine output of mux.
end

endmodule
