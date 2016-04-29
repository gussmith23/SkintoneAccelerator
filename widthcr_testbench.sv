`include "datapath.vh"

module widthcr_testbench();

reg		[7:0]					Y;
wire 	[`widthcr_width -1:0]	out;

real widthcr_actual;
real widthcr_found;

widthcr dut(Y, out);

initial begin
	$display("actual\t\tfound\t\tfound (bits)\n");
	//$monitor("%d\t\t%b",Y,out);
	for (integer i = 0; i < 256; i++) 
        begin
		Y = i;
		#5;
                
                if (Y <= `K_l) 
                  widthcr_actual = `WL_Cr + (Y - `Y_min )*(`W_Cr - `WL_Cr)/(`K_l - `Y_min );
                else if (`K_h <= Y)
                  widthcr_actual = `WH_Cr + (`Y_max - Y)*(`W_Cr - `WH_Cr )/(`Y_max - `K_h );
                else widthcr_actual = 0.0;

                convert_from_fixed(out, widthcr_found);

                $display("%f\t\t%f\t\t%b", widthcr_actual, widthcr_found, out);
	end
end

endmodule
