/* Or Gate Module
Functions exactly like an OR gate, returning 1 if one or more of the input bits is 1.
*/

module myOr (
  input wire Sig1,
  input wire Sig2,
  output wire Out
);

assign Out = Sig1 | Sig2;

endmodule
