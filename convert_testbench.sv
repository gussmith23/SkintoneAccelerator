 `include "datapath.h"

module convert_testbench();

real				a,b;
reg [`fp_width-1:0]	temp;
real 				start = 100.0;
real				mult = 0.98;
real				add = -1.3;

initial begin
	a = start;
	$monitor("%f ~= %f (%b)", a, b, temp);
end

always #5 begin
	convert_to_fixed(a, temp);
	convert_from_fixed(temp, b);
	a = a*mult + add;
end
	
endmodule