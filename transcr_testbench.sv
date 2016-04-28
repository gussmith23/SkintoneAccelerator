`include "datapath.vh"

module transcr_testbench();

class Cr_Y_pair;
	rand bit[15:0] pair;
endclass;

reg 								clk;
reg 		[7:0]					Cr;
reg 		[7:0]					Y;
wire		[`transcr_output - 1:0]	transcr;

Cr_Y_pair pair;

transcr dut(clk, Cr, Y, transcr);

initial begin
	$monitor("%b\t%b\t%b", Cr, Y, transcr);
	clk = 0;
	pair = new();
end

always #5 begin
	clk = !clk;
	pair.randomize();
	Cr = pair.pair[15:8];
	Y = pair.pair[7:0];
end

always #1000 $finish();
endmodule