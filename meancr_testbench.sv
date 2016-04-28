`include "datapath.vh"

module meancr_testbench();

reg		[7:0]					Y;
wire 	[`meancr_width -1:0]	out;

meancr dut(Y, out);

initial begin
	$display("Y\t\tout\n");
	$monitor("%d\t\t%b",Y,out);
	for (integer i = 0; i < 256; i++) begin
		Y = i;
		#5;
	end
end

endmodule