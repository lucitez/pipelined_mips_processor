/* Equals Module
Compares the values in two registers, returning 1 if equal, 0 if not.
*/

module equals (
  input wire [31:0] Reg1,
  input wire [31:0] Reg2,
  output reg Boolean
);

always @ (Reg1, Reg2)
  Boolean = (Reg1 == Reg2) ? 1 : 0;

endmodule
