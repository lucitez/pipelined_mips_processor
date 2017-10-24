/* Ander module
An and gate: Takes in two one bit inputs and returns 1 if both inputs
are 1, 0 in any other case.
*/

module ander (
  input FirstBit,
  input SecondBit,
  output wire Result
);

assign Result = FirstBit && SecondBit;

endmodule
