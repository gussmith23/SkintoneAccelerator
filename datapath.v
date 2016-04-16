`include "datapath.vh"

module skintone_datapath
(
	input				clk, 
	input 				rst,
	input 	[23:0]			pixel_datain, 
	input				pixel_datain_valid,
	input				pixel_datain_ready,
	output	[7:0]			result_dataout,
	output				result_dataout_valid,
	output				result_dataout_ready
);

// Contains valid_in bit for stages 0 through 15.
reg 	[15:0]		valid_in;



endmodule