/* Alu Module
 * Performs arithmatic operations on the two inputs depending on the aluop and
 * puts the result on the output.
 */
module alu (
	input [3:0] AluOp,
	input [31:0] Input1,
	input [31:0] Input2,
	output reg [31:0] Result
);

always @ (*) begin
	// behavior depends on the aluop code
	case(AluOp)
		`ALU_ADD: Result = Input1 + Input2;
		`ALU_SUB: Result = Input1 - Input2;
		`ALU_AND: Result = Input1 & Input2;
		`ALU_OR:  Result = Input1 | Input2;
		`ALU_SLT: Result = Input1 < Input2 ? 1 : 0;
		`ALU_LUI: Result = Input2 << 16;
		default: $write("");
	endcase
end

endmodule
