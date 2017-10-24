/* Sign Extension Module
Takes a 16 bit value and extends it to be 32 bits with the same value in
twos-complement
*/
module sign_extend (
	input [15:0] In,
	output reg [31:0] Out
);

always @ (*) begin
	Out = {{16{In[15]}}, In};
end

endmodule
