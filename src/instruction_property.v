/* Instruction Property Module
Module that takes in an Instruction and extracts all of the necessary attributes.
*/

module instruction_property (
  input wire [31:0] Instr,
  output reg [2:0] IRJ,
  output reg [4:0] RS,
  output reg [4:0] RT,
  output reg [4:0] RD
);

always @ (*) begin
	RS <= Instr[25:21];
	RT <= Instr[20:16];
	RD <= Instr[15:11];

  // Alter IRJ bits depending on the Instruction type
	IRJ[0] <= Instr[31:26] == `J || Instr[31:26] == `JAL;
	IRJ[1] <= Instr[31:26] == `SPECIAL;
	IRJ[2] <= !(Instr[31:26] == `J || Instr[31:26] == `JAL) && !(Instr[31:26] == `SPECIAL);
end

endmodule
