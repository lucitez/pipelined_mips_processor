/*
* Module to test the functionality of the instruction_property module
*/
module instruction_property_test();

`define I 3'b100
`define R 3'b010
`define J 3'b001

`define ASSERTIFY assertify = 1; assertify = 0; #5;

reg [31:0] instr;
wire [2:0] irj;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;

reg assertify = 0;
reg [4:0] real_reg;
reg [4:0] exp_reg;
reg [2:0] exp_irj;

initial begin
	instr = 31'h21490009; //addi $t1 $t2 0x9
	#5;
	$display("Testing - addi $t1 $t2 0x9 - instr: %x", instr);
	//I type
	exp_irj = `I;
	`ASSERTIFY

	real_reg = rt;
	exp_reg = `t1;
	`ASSERTIFY
	
	real_reg = rs;
	exp_reg = `t2;
	`ASSERTIFY

	// --------------------------------------------------
	instr = 31'h012A4020; //add $t0 $t1 $t2
	#5;
	$display("Testing - add $t0 $t1 $t2 - instr: %x", instr);

	exp_irj = `R;
	`ASSERTIFY;

	real_reg = rs;
	exp_reg = `t1;
	`ASSERTIFY

	real_reg = rt;
	exp_reg = `t2;
	`ASSERTIFY

	real_reg = rd;
	exp_reg = `t0;
	`ASSERTIFY

	// -------------------------------------------------
	instr = 31'h082FFFFF;
	#5;
	$display("Testing - j 0x02ffff - instr: %x", instr);

	exp_irj = `J;
	`ASSERTIFY

end

instruction_property instr_prop(
	instr,
	irj,
	rs,
	rt,
	rd);

assert #(.BITS(3))  assert_irj(
	irj,
	exp_irj,
	assertify,
	"InstrPropIrj"
);

assert #(.BITS(5))  assert_reg(
	real_reg,
	exp_reg,
	assertify,
	"InstrPropReg"
);

// always @(*) begin
// 	$monitor("Properties - irj: %x - rs: %x - rt: %x - rd: %x", irj, rs, rt, rd);
// end

endmodule
