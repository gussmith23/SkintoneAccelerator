`include "datapath.vh"

module widthcr_testbench();

reg		[7:0]					Y;
wire 	[`widthcr_width -1:0]	out;

widthcr dut(Y, out);

initial begin
	$display("Y\t\tout\n");
	$monitor("%d\t\t%b",Y,out);
	for (integer i = 0; i < 256; i++) begin
		Y = i;
		#5;
	end
end

endmodule