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

class pixel_t;
	rand bit [23:0] data;
endclass

pixel_t pixel;

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
	pixel = new();
	clk = 0;
	cycles = 0;
	pixel_datain_valid = 0;
end

always #10 begin
	cycles++;
	pixel.randomize();
	pixel_datain_ready = 1; pixel_datain_valid = 1;
	pixel_datain = pixel.data;
	
	$display("%d %d %d %d\n", cycles, pixel_datain_valid, result_dataout_valid, result_dataout);
	
end

always #5 begin
	clk = !clk;
end

//always #50 pixel_datain_valid = !pixel_datain_valid;

always #1000 $finish();

endmodule
