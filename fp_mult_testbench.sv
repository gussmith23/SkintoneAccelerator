`include "datapath.h"

module fp_mult_testbench();

reg [`fp_width-1:0]	a, b, out;

fp_mult 
	#(.fp_width(`fp_width), .fp_frac(`fp_frac)) 
	mult(a, b, out);
	
endmodule