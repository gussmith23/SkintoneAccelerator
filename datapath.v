///
/// Pipelined in stages 0-15.
///

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


/// BEHAVIORAL CODE

//-Valid bits---------------------------------------------
always @ (posedge clk) valid_in[0] <= pixel_datain_valid;
assign result_dataout_valid = valid_in[15];
genvar i;
generate
	for (i = 0; i < 15; i = i + 1) begin
		always @ (posedge clk)  valid_in[i+1] <= valid_in[i];
	end
endgenerate
//-End valid bits-----------------------------------------

endmodule