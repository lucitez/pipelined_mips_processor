/* System Call Handler
Handles when there are Syscalls.
*/
module sys_handler (
	input Syscall,
	input [31:0] A0,
	input [31:0] V0,

	output reg Print
);

initial begin
	Print <= 0;
end

always @ (Syscall) begin
	if (Syscall) begin
		if (V0 == 1) begin // Print integer
			$write("Printing integer:");
			$display("%d", $signed(A0));
		end
		else if (V0 == 10) begin // End program
			$display("finishing");
			$finish;
		end
		else if (V0 == 4) begin // Print string
			Print = 1; Print = 0; // Must flip back to 0
		end
		else begin
			$display("Unsupported Syscall, V0: 0x%x", V0);
		end
	end
end

endmodule
