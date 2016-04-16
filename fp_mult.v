`include "datapath.h"

module fp_mult
#(
	parameter fp_width 		= 16,
	parameter fp_frac		= 8
)
(
	input 		[`fp_mult_input_width - 1 : 0]		a,
	input 		[`fp_mult_input_width - 1 : 0]		b,
	output	reg	[`fp_mult_output_width - 1 : 0]		out
);

localparam fp_int = fp_width - fp_frac - 1;
reg [2*fp_width - 1:0]	temp;

always @ (a, b) begin
	temp = a*b;
	temp = temp >> fp_frac;
	out = temp[fp_width-1:0];
end

endmodule