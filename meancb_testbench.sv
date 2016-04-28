`include "datapath.vh"

module meancb_testbench();

reg		[7:0]					Y;
wire 	[`meancb_width -1:0]	out;

meancb dut(Y, out);

initial begin
	$display("Y\t\tout\n");
	$monitor("%d\t\t%b\n",Y,out);
	for (integer i = 0; i < 256; i++) begin
		Y = i;
		#5;
	end
end

endmodule