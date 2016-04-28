`include "datapath.vh"

module datapath_testbench();

reg				clk;
reg				rst;
reg		[23:0]	pixel_datain;
reg				pixel_datain_valid;
reg				pixel_datain_ready;
reg		[7:0]	result_dataout;
reg				result_dataout_valid;
reg				result_dataout_ready;

integer cycles;

skintone_datapath dut(
	clk, 
	rst,
	pixel_datain, 
	pixel_datain_valid,
	pixel_datain_ready,
	result_dataout,
	result_dataout_valid,
	result_dataout_ready
);

initial begin
	clk = 0;
	cycles = 0;
	pixel_datain_valid = 0;
	$monitor("%d %d %d\n", cycles, pixel_datain_valid, result_dataout_valid);
end

always #5 begin
	clk = !clk;
	cycles++;
end

always #50 pixel_datain_valid = !pixel_datain_valid;

always #1000 $finish();

endmodule