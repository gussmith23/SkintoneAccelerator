`ifndef _skintone_datapath_vh_
`define _skintone_datapath_vh_

`define W_Cb 46.97
`define WL_Cb 23
`define WH_Cb 14
`define W_Cr 38.76
`define WL_Cr 20
`define WH_Cr 10
`define K_l 125
`define K_h 188

`define Cx 109.38
`define Cy 152.02
`define Theta 2.53
`define ECx 1.60
`define ECy 2.41
`define A 25.39
`define B 14.03
`define Y_min 16
`define Y_max 235

`define cos_t -0.81873459927
`define sin_t 0.57417214835

`define A2 644.6521
`define B2 196.8409

`define radius 255
`define fac 510

/// FIXED POINT DEFINITIONS
// Currently: Q9.6
`define fp_width 16
`define fp_frac 6
`define fp_int `fp_width - `fp_frac - 1

// Assumes that we want the fp parameters defined above.
// Doing arbitrary conversion is possible but messy (i think)
module conversion_tasks();
task convert_to_fixed;
	input real a;
	output reg signed [`fp_width - 1:0] out;
	
	real shifted;
	
	begin	
		shifted = a * 2.0**(`fp_frac);
		out = $rtoi(shifted);
	end
endtask

task convert_from_fixed;
	input reg signed [`fp_width - 1:0] in;
	output real a;
	
	integer temp_int;
	real temp_real;
	
	begin
		temp_int = in;
		temp_real = $itor(temp_int);
		a = temp_real * 2.0**(-1 * `fp_frac);
	end
	
endtask
endmodule


/// END FIXED POINT DEFINITIONS

`define meancr_width 16
`define widthcr_width 16
`define meancb_width 16
`define widthcb_width 16

`define transcr_output 8
`define transcb_output 8

`define fp_mult_input_width `fp_width
`define fp_mult_output_width `fp_width

`define meancr_K_h 16'b1001101000000000
`define meancb_K_h 16'b0110110000000000

// Auto generated defines. See generate_defines.c.
`define neg_sint_fp 16'b1111111110110111
`define cost_fp 16'b1111111110011000
`define sint_fp 16'b0000000001001001
`define A2_inv_fp 16'b0000000000000000
`define B2_inv_fp 16'b0000000000000000
`define fac_fp 16'b1111111100000000
`define Cx_fp 16'b0011011010110000
`define Cy_fp 16'b0100110000000010
`define ECx_fp 16'b0000000011001100
`define ECy_fp 16'b0000000100110100
`define Radius_fp 16'b0111111110000000


`endif