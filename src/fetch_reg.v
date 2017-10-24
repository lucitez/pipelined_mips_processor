/*
This module is used to stall the fetch stage of the pipeline. Sets PC Prime
*/

module fetchReg (
	input clk,
	input StallF,
	input wire [31:0] PCP,
	output reg [31:0] PCF
);

initial begin
	PCF <= `PROGRAM_START;
end

always @ (posedge clk) begin
	if (!StallF) begin //if not stall, continue (EG, if we're not stalling, fetch)
			PCF <= PCP;
	end
end

endmodule
