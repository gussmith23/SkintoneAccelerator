`include "datapath.h"

module fp_mult_testbench();

reg [`fp_width-1:0]	a, b, out;
real 				a_real, b_real, out_real;

fp_mult 
	#(.fp_width(`fp_width), .fp_frac(`fp_frac)) 
	mult(a, b, out);
	
initial begin
	$monitor("%f * %f = %f\n", a_real, b_real, out_real);
end

always #5 begin
	a_real = 1.5;
	b_real = 1.5;
	convert_to_fixed (a_real, a);
	convert_to_fixed (b_real, b);
end

always @ (out) convert_from_fixed (out, out_real);
	
endmodule