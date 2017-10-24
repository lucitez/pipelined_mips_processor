/* Printing Module
This module takes in a string to print, a control bit, and the address A0.
It outputs a new address to print, which goes to instruction_memory to update
the string to print.
*/

module printing (
	// The ascii to hex string to print
	input [31:0] StrPrint,
	// Boolean to activate this module
	input Print,
	input [31:0] A0,
	output reg [31:0] StrPrintAddr
);

//current letter
reg [7:0] letter;
reg still_printing;

integer i;

initial begin
	still_printing = 0;
end

// This module is activated by flipping print from 0 to 1 (hence posedge).
always @ (posedge Print) begin
	still_printing = 1;
	StrPrintAddr = A0;
end

always @ (StrPrint) begin // Triggers when a new string to print comes into the module.
	if (still_printing) begin
		for (i = 4; i > 0; i = i - 1) begin // Work backwards through the chunk
			if (i == 4) begin
				letter = StrPrint[7:0];
			end else if ( i == 3) begin
				letter = StrPrint[15:8];
			end else if ( i == 2) begin
				letter = StrPrint[23:16];
			end else begin
				letter = StrPrint[31:24];
			end

			if (letter == 0) begin
				still_printing = 0; // Hit null terminator, stop printing.
			end else begin
				$write("%s", letter);
			end
		end
		if (~still_printing) // Adds newline
			$display("");

		StrPrintAddr = StrPrintAddr + 4; // Update printaddr so that StrPrint changes, thus continuing the printing.
	end
end

endmodule
