`include "datapath.vh"

module fp_mult
#(
	parameter fp_width 		= `fp_width,
	parameter fp_frac		= `fp_frac
)
(
	input 	signed	[`fp_mult_input_width - 1 : 0]		a,
	input 	signed	[`fp_mult_input_width - 1 : 0]		b,
	output	signed 	[`fp_mult_output_width - 1 : 0]		out
);

localparam fp_int = fp_width - fp_frac - 1;
reg signed [2*fp_width - 1:0]	temp;
reg signed [`fp_mult_output_width - 1 : 0] out_reg;

assign out = out_reg;

always @ (a, b) begin
	temp = a*b;
	out_reg = temp[fp_width - 1 + fp_frac : fp_frac];
end

endmodule
