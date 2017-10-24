/*
This module is used to stall the decode stage. Passes current instruction through when not stalled
*/

module decode_reg (
	input clk,
	input StallD,
	input ClrD,
	input wire [31:0] InstrF,
	input wire [31:0] PcPlusFourF,
	output reg [31:0] InstrD,
	output reg [31:0] PcPlusFourD
);

always @(posedge clk) begin
	if (!StallD) begin // if not stall, continue (EG, if we're not stalling, decode)
		InstrD <= InstrF;
		PcPlusFourD <= PcPlusFourF;
	end

	if (ClrD) begin
		InstrD <= 32'h00000000;
		PcPlusFourD <= 32'h00000000;
	end
end

endmodule
