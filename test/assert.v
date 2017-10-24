/* Assert module allows assertion functionality for testing modules
 */
`define MAX_STR_LEN 12

module assert(
	input [BITS-1:0] val1,
	input [BITS-1:0] val2,
	input assertify,
	input [(`MAX_STR_LEN*8)-1:0] msg
);

parameter BITS = 32;

always @(posedge assertify) begin
	if(val1 != val2) begin
		$display("%s - first: %h does not equal second: %h", msg, val1, val2);
	end
end

endmodule
