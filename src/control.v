/* Control Module
 * Takes in the Opcode and Funccode for an instruction and produces an array
 * of control signals that control how the rest of the modules act
 */
module control (
	input [5:0] Opcode,
	input [5:0] Funccode,
	output reg RegDst,
	output reg Jump,
	output reg Jal,
	output reg Jr,
	output reg Branch,
	output reg MemRead,
	output reg MemToReg,
	output reg [3:0] AluOp,
	output reg RegWrite,
	output reg AluSrc,
	output reg MemWrite,
	output reg Syscall
);

// Necessary for the beginning of programs to ensure the security of the first few clock cycles.
initial begin
	Branch <= 0;
	Jal <= 0;
	Jr <= 0;
	Jump <= 0;
end

always @ (*) begin

	//Jump
	Jump = ( Opcode == `J || (( Opcode == `SPECIAL ) && (Funccode == `JR )) || Opcode == `JAL ) ? 1 : 0;
	Jr = (( Opcode == `SPECIAL ) && (Funccode == `JR )) ? 1 : 0;
	Jal = ( Opcode == `JAL ) ? 1 : 0;

	//RegDst
	case(Opcode)
		`SPECIAL: RegDst <= 1;
		`SW, `BEQ, `BNE, `J, `JR, `JAL: RegDst <= 1'bX;
		default: RegDst <= 0;
	endcase

	//Branch
	case(Opcode)
		`BEQ, `BNE: Branch <= 1;
		default: Branch <= 0;
	endcase

	//MemRead
	MemRead <= (Opcode == `LW);

	//MemToReg
	case(Opcode)
		`LW: MemToReg <= 1;
		`SW, `BEQ, `BNE: MemToReg <= 1'bX;
		default: MemToReg <= 0;
	endcase

	//AluOp
	case(Opcode)
		`SPECIAL: begin
				case(Funccode)
					`ADD: AluOp <= `ALU_ADD;
					`SUB: AluOp <= `ALU_SUB;
					`AND: AluOp <= `ALU_AND;
					`OR:  AluOp <= `ALU_OR;
					`SLT: AluOp <= `ALU_SLT;
					// by "tricking the cpu into thinking Syscall is an add instruction, will just
					// peform "add $0 $0 $0" since all bits except Funccode are 0
					`SYSCALL: AluOp <= `ALU_ADD;
				endcase
			end
		`ADDI, `ADDIU, `LW, `SW, `LB: AluOp <= `ALU_ADD;
		`BEQ, `BNE: AluOp <= `ALU_SUB;
		`LUI: AluOp <= `ALU_LUI;
		`ORI: AluOp <= `ALU_OR;
	endcase

	//RegWrite
	case(Opcode)
		`SPECIAL, `ADDI, `ADDIU, `ORI, `LW, `JAL, `LUI: RegWrite <= 1;
		default: RegWrite <= 0;
	endcase

	//AluSrc
	case(Opcode)
		`SPECIAL, `BEQ, `BNE: AluSrc <= 0;
		`J, `JR, `JAL: AluSrc <= 1'bX;
		default: AluSrc <= 1;
	endcase

	//MemWrite
	MemWrite <= (Opcode == `SW);

	//Syscall
	Syscall <= ((Opcode == `SPECIAL) && (Funccode == `SYSCALL));
end

endmodule
