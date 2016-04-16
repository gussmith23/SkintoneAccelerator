`include "datapath.h"

module fp_mult
#(
	parameter num_frac_bits  = 8
)
(
	input 	[`fp_mult_input_width - 1 : 0]		a,
	input 	[`fp_mult_input_width - 1 : 0]		b,
	output	[`fp_mult_output_width - 1 : 0]		out
);

