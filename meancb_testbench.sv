`include "datapath.vh"

module meancb_testbench();

reg		[7:0]					Y;
wire 	[`meancb_width -1:0]	out;

real meancb_actual;
real meancb_found;

meancb dut(Y, out);

initial begin
	$display("actual\t\tfound\t\tfound (bits)\n");
	//$monitor("%d\t\t%b",Y,out);
	for (integer i = 0; i < 256; i++) begin
		Y = i;
		#5;
                
                if (Y <= `K_l) meancb_actual = 108.0 + 10.0*(`K_l - Y)/(`K_l - `Y_min );
                else if (`K_h <= Y)
                  meancb_actual = 108.0 + 10.0*(Y- `K_h )/(`Y_max - `K_h );
                else meancb_actual = 0.0;

                convert_from_fixed(out, meancb_found);

                $display("%f\t\t%f\t\t%b", meancb_actual, meancb_found, out);
	end
end

endmodule
