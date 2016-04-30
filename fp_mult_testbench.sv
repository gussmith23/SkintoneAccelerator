`include "datapath.vh"

// TODO this module and add_sub_testbench display misleading results;
// they say something like a1 * b1 ~= c1 \n a2 * b2 ~= c2, though
// a1 * b1's result is actually c2. so everything is shifted down, in a way.
// However, the modules both work correctly, so correcting this
// isn't a high priority.

module fp_mult_testbench();

reg signed		[`fp_width-1:0]		a, b, out;
real 								a_real, b_real, out_real;

real start = 5.0;
real scale = 1.0;
real add = -0.3;

fp_mult 
	#(.fp_width(`fp_width), .fp_frac(`fp_frac)) 
	mult(a, b, out);
	
initial begin
	a_real = start;
	b_real = start;
	$monitor("%f * %f ~= %f\n", a_real, b_real, out_real);
end

always #5 begin
	convert_to_fixed (a_real, a);
	convert_to_fixed (b_real, b);
	a_real = a_real*scale + add;
	b_real = b_real*scale - add;
end

always @ (out) convert_from_fixed (out, out_real);
	
endmodule