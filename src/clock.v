/* Clock Module
 * Outputs a signal that inverts iteself every 5 units of time
 */
module clock (
	output reg clock
);

initial begin
	clock = 0;
end

always begin
	#5 clock = ~clock;
end


endmodule
