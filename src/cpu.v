//This is the top level module for our processor
module cpu();

wire clock;

//Fetch Control bits
wire regWriteD;
wire memToRegD;
wire memWriteD;
wire memReadD;
wire [3:0] aluControlD;
wire aluSrcD;
wire regDestD;
wire branchD;
wire jumpD;
wire jalD;
wire jrD;
wire syscallD;

//Execute control bits
wire regWriteE;
wire memToRegE;
wire memWriteE;
wire [3:0] aluControlE;
wire aluSrcE;
wire regDestE;
wire syscallE;

//Memory control bits
wire regWriteM;
wire memToRegM;
wire memWriteM;
wire syscallM;

//Writeback control bits
wire regWriteW;
wire memToRegW;
wire syscallW;

wire startPrinting;
wire keepPrinting;

// Used by more than one stage
wire [31:0] branchAddress;
wire [31:0] jumpOrBranchAddress;
wire jumpOrBranchControl;

//Fetch Stage, declaring wires / registers only used by this stage
//wire branching;

wire [31:0] instructionF;
wire [31:0] pcPlusFourF;
wire [31:0] newPC;
wire [31:0] currPc;

wire [31:0] pcPlusFourD;
wire [31:0] pcPlusEightD;
wire [31:0] shiftConcattedJumpAddr;
wire [31:0] jumpAddr;

// Decode Stage
wire [31:0] instructionD;
wire [31:0] signExtendedInstructionD;
wire [31:0] shiftOut;

wire [4:0] writeRegW;
wire [4:0] writeReg;
wire [31:0] writeData;
wire [31:0] readData1;
wire [31:0] readData2;
wire [31:0] beqReg1;
wire [31:0] beqReg2;
wire [31:0] a0;
wire [31:0] v0;
wire equalD;

// Execute Stage
wire [4:0] rSE;
wire [4:0] rTE;
wire [4:0] rDE;
wire [31:0] signImmE;
wire [4:0] writeRegE;
wire [31:0] readReg1E;
wire [31:0] readReg2E;

wire [31:0] srcAE;
wire [31:0] aluMuxOutB;
wire [31:0] srcBE;
wire [31:0] writeDataE;
wire [31:0] aluResultE;

//Memory Stage;
wire [31:0] readDataM;
wire [4:0] writeRegM;
wire [31:0] aluOutM;
wire [31:0] writeDataM;
wire [31:0] writeDataRes;

//Writeback Stage
wire [31:0] readDataW;
wire [31:0] aluOutW;
wire [31:0] resultW;

// Hazard Unit
wire [2:0] instrTypeIrj;
wire [4:0] hzrdRs;
wire [4:0] hzrdRt;
wire [4:0] hzrdRd;

wire stallD;
wire stallF;
wire flushE;
wire [1:0] forwardAE;
wire [1:0] forwardBE;
wire forwardAD;
wire forwardBD;
wire forwardMM;

//string printing
wire [31:0] strPrintAddr;
wire [31:0] strPrint;
wire print;

// Fetch stage
clock processorClock (.clock(clock));

fetchReg instructionFetch (
  .clk(clock),
  .StallF(stallF),
  .PCP(newPC),
  .PCF(currPc)
);

instr_memory processorInstructionMemory (
  .ByteAddress(currPc),
  .StrPrintAddr(strPrintAddr),
  .Instruction(instructionF),
  .StrPrint(strPrint)
);

plusFourAdder pcPlusFourAdder (
  .In(currPc),
  .Out(pcPlusFourF)
);

mux_1bit jumpOrBranch (
  .Control(jumpD),
  .IfZero(branchAddress),
  .IfOne(jumpAddr),
  .Out(jumpOrBranchAddress)
);

myOr jumpOrBranchSignal (
  .Sig1(jumpD),
  .Sig2(branching),
  .Out(jumpOrBranchControl)
);

mux_1bit jumpMux (
  .Control(jumpOrBranchControl),
  .IfZero(pcPlusFourF),
  .IfOne(jumpOrBranchAddress),
  .Out(newPC)
);

mux_1bit jumpRegMux (
  .Control(jrD),
  .IfZero(shiftConcattedJumpAddr),
  .IfOne(readData1),
  .Out(jumpAddr)
);

// Decode Stage

decode_reg instructionDecode (
  .clk(clock),
  .StallD(stallD),
  .ClrD(1'b0), //TODO: this is not right, needs to be updated
  .InstrF(instructionF),
  .PcPlusFourF(pcPlusFourF),
  .InstrD(instructionD),
  .PcPlusFourD(pcPlusFourD)
);

shift_concat shiftConcatDecode (
  .NewPC(pcPlusFourD [31:28]),
  .In(instructionD [25:0]),
  .Out(shiftConcattedJumpAddr)
);

plusFourAdder pcPlusAnotherFourAdder (
  .In(pcPlusFourD),
  .Out(pcPlusEightD)
);

control processorControl (
  .Opcode(instructionD [31:26]),
  .Funccode(instructionD [5:0]),
  .RegDst(regDestD),
  .Jump(jumpD),
  .Jal(jalD),
  .Jr(jrD),
  .Branch(branchD),
  .MemRead(memReadD),
  .MemToReg(memToRegD),
  .AluOp(aluControlD),
  .RegWrite(regWriteD),
  .AluSrc(aluSrcD),
  .MemWrite(memWriteD),
  .Syscall(syscallD)
);

register processorRegisters (
  .clk(clock),
  .RegWrite(regWriteW),
  .ReadReg1(instructionD[25:21]),
  .ReadReg2(instructionD[20:16]),
  .WriteReg(writeRegW),
  .WriteData(resultW),
  .Jal(jalD),
  .JalAddr(pcPlusEightD),
  .ReadData1(readData1),
  .ReadData2(readData2),
  .A0(a0),
  .V0(v0)
);

sign_extend signExtend (
  .In(instructionD [15:0]),
  .Out(signExtendedInstructionD)
);

shift_left signExtendShiftLeft (
  .In(signExtendedInstructionD),
  .Out(shiftOut)
);

adder signExtendPlusFour (
  .InOne(shiftOut),
  .InTwo(pcPlusFourD),
  .Out(branchAddress)
);

equals beq (
  .Reg1(beqReg1),
  .Reg2(beqReg2),
  .Boolean(equalD)
);

ander branchSend (
  .FirstBit(branchD),
  .SecondBit(equalD),
  .Result(branching)
);

mux_1bit decodeForwardMux1 (
  .Control(forwardAD),
  .IfZero(readData1),
  .IfOne(aluOutM),
  .Out(beqReg1)
);

mux_1bit decodeForwardMux2 (
  .Control(forwardBD),
  .IfZero(readData2),
  .IfOne(aluOutM),
  .Out(beqReg2)
);

// Execute Stage
execute_reg executeInstruction (
  .clk(clock), //inputs
  .FlushE(flushE),
  .RegWriteD(regWriteD),
  .MemtoRegD(memToRegD),
  .MemWriteD(memWriteD),
  .ALUControlD(aluControlD),
  .ALUSrcD(aluSrcD),
  .RegDstD(regDestD),
  .syscallD(syscallD),
  .RsD(instructionD[25:21]),
  .RtD(instructionD[20:16]),
  .RdD(instructionD[15:11]),
  .SignImmD(signExtendedInstructionD),
  .Rd1D(readData1),
  .Rd2D(readData2),

  .RegWriteE(regWriteE),  //Outputs
  .MemtoRegE(memToRegE),
  .MemWriteE(memWriteE),
  .ALUControlE(aluControlE),
  .ALUSrcE(aluSrcE),
  .RegDstE(regDestE),
  .syscallE(syscallE),
  .RsE(rSE),
  .RtE(rTE),
  .RdE(rDE),
  .SignImmE(signImmE),
  .Rd1E(readReg1E),
  .Rd2E(readReg2E)
);

mux_1bit #(.BITS(4)) regChoiceMux (
  .Control(regDestE),
  .IfZero(rTE),
  .IfOne(rDE),
  .Out(writeRegE)
);

mux_2bit aluMuxA (
  .Control(forwardAE),
  .IfZero(readReg1E),
  .IfOne(resultW),
  .IfTwo(aluOutM),
  .Out(srcAE)
);

mux_2bit aluMuxB (
  .Control(forwardBE),
  .IfZero(readReg2E),
  .IfOne(resultW),
  .IfTwo(aluOutM),
  .Out(aluMuxOutB)
);

mux_1bit aluBResultMux (
  .Control(aluSrcE),
  .IfZero(aluMuxOutB),
  .IfOne(signImmE),
  .Out(srcBE)
);

alu processorAlu (
  .AluOp(aluControlE),
  .Input1(srcAE),
  .Input2(srcBE),
  .Result(aluResultE)
);

//Memory Stage;
mem_reg memoryRegister (
  .clk(clock), //inputs
  .RegWriteE(regWriteE),
  .MemtoRegE(memToRegE),//HERE
  .MemWriteE(memWriteE),
  .SyscallE(syscallE),
  .ALUOutE(aluResultE),
  .WriteDataE(aluMuxOutB),
  .WriteRegE(writeRegE),

  .RegWriteM(regWriteM), //Outputs
  .MemtoRegM(memToRegM),
  .MemWriteM(memWriteM),
  .SyscallM(syscallM),
  .ALUOutM(aluOutM),
  .WriteDataM(writeDataM),
  .WriteRegM(writeRegM)
);

mux_1bit wbDataMux (
  .Control(forwardMM),
  .IfZero(writeDataM),
  .IfOne(resultW),
  .Out(writeDataRes)
);

data_memory dataMemory (
  .MemWrite(memWriteM),
  .Address(aluOutM),
  .WriteData(writeDataRes),
  .ReadData(readDataM)
);

//Writeback Stage
writeback_reg wbReg (
  .clk(clock),
  .RegWriteM(regWriteM),
  .MemtoRegM(memToRegM),
  .SyscallM(syscallM),
  .ReadDataM(readDataM),
  .ALUOutM(aluOutM),
  .WriteRegM(writeRegM),

  .RegWriteW(regWriteW),
  .MemtoRegW(memToRegW),
  .SyscallW(syscallW),
  .ReadDataW(readDataW),
  .ALUOutW(aluOutW),
  .WriteRegW(writeRegW)
);

mux_1bit wbMux (
  .Control(memToRegW),
  .IfZero(aluOutW),
  .IfOne(readDataW),
  .Out(resultW)
);

// Syscall

sys_handler processorSyscall (
  .Syscall(syscallW),
  .A0(a0),
  .V0(v0),
  .Print(print)
);

printing sysPrintString(
	.StrPrint(strPrint),
	.Print(print),
	.A0(a0),
	.StrPrintAddr(strPrintAddr)
);

// Hazard Unit

instruction_property instr_prop(
  .Instr(instructionD),
  .IRJ(instrTypeIrj),
  .RS(hzrdRs),
  .RT(hzrdRt),
  .RD(hzrdRd)
);

hazard_unit hzrd_unit(
  .clk(clock),
  .DC_irj(instrTypeIrj),
  .DC_rs(hzrdRs),
  .DC_rt(hzrdRt),
  .DC_rd(hzrdRd),
  .DC_instr(instructionD),
  .BranchD(branchD),
  .MemtoRegE(memToRegE),
  .RegWriteE(regWriteE),
  .MemtoRegM(memToRegM),
  .RegWriteM(regWriteM),
  .RegWriteW(regWriteW),

  .StallF(stallF),
  .StallD(stallD),
  .ForwardAD(forwardAD),
  .ForwardBD(forwardBD),
  .FlushE(flushE),
  .ForwardAE(forwardAE),
  .ForwardBE(forwardBE),
  .ForwardMM(forwardMM)
);

initial begin
   $dumpfile("gtkwave.vcd");
   $dumpvars(0,cpu);
end

always @ (posedge clock) begin
  // $monitor($time, "instr: %x, print: %x, strPrintAddr: %x, strPrint: %x, a0: %x, aluOut: %x, srcAE: %x, srcBE: %x, v0: %x", instructionD, print, strPrintAddr, strPrint, a0, aluResultE, srcAE, srcBE, v0);
end

always begin
  #500; $finish;
end
endmodule
