`include "datapath.vh"

module widthcb_testbench();

reg		[7:0]					Y;
wire 	[`widthcb_width -1:0]	out;

real widthcb_actual;
real widthcb_found;

widthcb dut(Y, out);

initial begin
	$display("actual\t\tfound\t\tfound (bits)\n");
	//$monitor("%d\t\t%b",Y,out);
	for (integer i = 0; i < 256; i++) 
        begin
		Y = i;
		#5;
                
                if (Y <= `K_l) 
                  widthcb_actual = `WL_Cb + (Y - `Y_min )*(`W_Cb - `WL_Cb)/(`K_l - `Y_min );
                else if (`K_h <= Y)
                  widthcb_actual = `WH_Cb + (`Y_max - Y)*(`W_Cb - `WH_Cb )/(`Y_max - `K_h );
                else widthcb_actual = 0.0;

                convert_from_fixed(out, widthcb_found);

                $display("%f\t\t%f\t\t%b", widthcb_actual, widthcb_found, out);
	end
end

endmodule
