`include "datapath.vh"

module meancr_testbench();

reg		[7:0]					Y;
wire 	[`meancr_width -1:0]	out;

real meancr_actual;
real meancr_found;

meancr dut(Y, out);

initial begin
	$display("actual\t\tfound\t\tfound (bits)\n");
	//$monitor("%d\t\t%b",Y,out);
	for (integer i = 0; i < 256; i++) 
        begin
		Y = i;
		#5;
                
                if (Y <= `K_l) meancr_actual = 154.0 + 10.0*(`K_l - Y)/(`K_l - `Y_min );
                else if (`K_h <= Y)
                  meancr_actual = 154.0 + 22.0*(Y- `K_h )/(`Y_max - `K_h );
                else meancr_actual = 0.0;

                convert_from_fixed(out, meancr_found);

                $display("%f\t\t%f\t\t%b", meancr_actual, meancr_found, out);
	end
end

endmodule
