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

// Stage 5
reg 	[`transcr_output - 1: 0] 	transcr_output5, transcb_output5;

// Stage 6
reg		[`fp_width - 1:0]			cb_sub_output6, cr_sub_output6;

// Stage 7
reg		[`fp_width - 1:0]	cb_mult0_output7, cb_mult1_output7,
								cr_mult0_output7, cr_mult1_output7;

// Stage 8
reg		[`fp_width - 1:0]	cb_add_output8, cr_add_output8;

// Stage 9
reg		[`fp_width - 1:0]	cb_sub_output9, cr_sub_output9;

// Stage 10
reg		[`fp_width - 1:0]	cb_mult_output10, cr_mult_output10;

// Stage 11
reg		[`fp_width - 1:0]	cb_mult_output11, cr_mult_output11;

// Stage 12
reg 	[`fp_width - 1:0]	add_output12;

// Stage 13
reg 	[`fp_width - 1:0]	sub_output13;
reg							radius_bool13;

// Stage 14
reg 	[`fp_width - 1:0]	mult_output14;
reg							radius_bool14;

// Stage 15
reg		[7:0]	skinscore15;

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