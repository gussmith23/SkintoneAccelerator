`include "datapath.vh"

module add_sub_testbench();

reg signed		[`fp_width-1:0]		a, b, sub_reg, add_reg;
real 								a_real, b_real, sub_real, add_real;

real start = 5.0;
real scale = 0.98;
real add = -0.3;

	
initial begin
	a_real = start;
	b_real = start;
	$monitor("%f + %f ~= %f, %f - %f ~= %f\n", a_real, b_real, add_real, a_real, b_real, sub_real);
end

always #5 begin
	convert_to_fixed (a_real, a);
	convert_to_fixed (b_real, b);
	add_reg = a+b;
	sub_reg = a-b;
	convert_from_fixed(add_reg, add_real);
	convert_from_fixed(sub_reg, sub_real);
	
	a_real = a_real*scale + add;
	b_real = b_real*scale - add;
end

always #500 $finish();	
endmodule