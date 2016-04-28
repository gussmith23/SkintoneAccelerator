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

// Stages 0-5
reg 	[`transcr_output - 1: 0] 	transcr_output5, transcb_output5;

transcr transcr_instance(
	.clk(clk),
	.Cr(pixel_datain[7:0]),
	.Y(pixel_datain[23:16]),
	.transcr(transcr_output5)
);

transcb transcb_instance(
	.clk(clk),
	.Cb(pixel_datain[15:8]),
	.Y(pixel_datain[23:16]),
	.transcb(transcb_output5)
);

// Stage 6
reg		[`fp_width - 1:0]			cb_sub_output6, cr_sub_output6;

// Stage 7
reg		[`fp_width - 1:0]	cb_mult0_output7, cb_mult1_output7,
								cr_mult0_output7, cr_mult1_output7;
								
fp_mult cb_mult0_7(`neg_sint_fp, cb_sub_output6, cb_mult0_output7);
fp_mult cb_mult1_7(`cost_fp, cb_sub_output6, cb_mult1_output7);
fp_mult cr_mult0_7(`cost_fp, cr_sub_output6, cr_mult0_output7);
fp_mult cr_mult1_7(`sint_fp, cr_sub_output6, cr_mult1_output7);


// Stage 8
reg		[`fp_width - 1:0]	cb_add_output8, cr_add_output8;

// Stage 9
reg		[`fp_width - 1:0]	cb_sub_output9, cr_sub_output9;

// Stage 10
reg		[`fp_width - 1:0]	cb_mult_output10, cr_mult_output10;

fp_mult cb_mult_10(cb_sub_output9, cb_sub_output9, cb_mult_output10);
fp_mult cr_mult_10(cr_sub_output9, cr_sub_output9, cr_mult_output10);

// Stage 11
reg		[`fp_width - 1:0]	cb_mult_output11, cr_mult_output11;

fp_mult cb_mult_11(`A2_inv_fp, cb_mult_output10, cb_mult_output11);
fp_mult cr_mult_11(`B2_inv_fp, cr_mult_output10, cr_mult_output11);

// Stage 12
reg 	[`fp_width - 1:0]	add_output12;

// Stage 13
reg 	[`fp_width - 1:0]	sub_output13;
reg							radius_bool13;

// Stage 14
reg 	[`fp_width - 1:0]	mult_output14;
reg							radius_bool14;

fp_mult mult_14(`fac_fp, sub_output13, mult_output14);

// Stage 15
reg		[7:0]	skinscore15;

// Output assignments
assign result_dataout = skinscore15;
assign result_dataout_valid = valid_in[15];
assign result_dataout_ready = valid_in[15];

/// BEHAVIORAL CODE

//-Valid bits---------------------------------------------
always @ (posedge clk) valid_in[0] <= pixel_datain_valid;
genvar i;
generate
	for (i = 0; i < 15; i = i + 1) begin
		always @ (posedge clk)  valid_in[i+1] <= valid_in[i];
	end
endgenerate
//-End valid bits-----------------------------------------

//-Stages 0-5------------------------------------------------
// These stages are handled by the transcr/transcb structural code.
//-End Stages 0-5-------------------------------------------

//-Stage 6------------------------------------------------

always @ (posedge clk) begin
	cb_sub_output6  <= transcb_output5 - `Cx_fp ;
	cr_sub_output6  <= `Cy_fp - transcr_output5;
end

//-End Stage 6-------------------------------------------

//-Stage 7------------------------------------------------
// Handled in structural code.
//-End Stage 7------------------------------------------

//-Stage 8------------------------------------------------

always @ (posedge clk) begin
	cb_add_output8 <= cb_mult1_output7 + cr_mult1_output7;
	cr_add_output8 <= cb_mult0_output7 + cr_mult0_output7;
end

//-End Stage 8-------------------------------------------

//-Stage 9------------------------------------------------

always @ (posedge clk) begin
	cb_sub_output9 <= `ECx_fp - cb_add_output8;
	cr_sub_output9 <= cb_add_output8 - `ECy_fp ;
end

//-End Stage 9-------------------------------------------

//-Stage 10------------------------------------------------
// Handled in structural code.
//-End Stage 10-------------------------------------------

//-Stage 11------------------------------------------------
// Handled in structural code.
//-End Stage 11-------------------------------------------

//-Stage 12------------------------------------------------

always @ (posedge clk) add_output12 <= cb_mult_output11 + cr_mult_output11;

//-End Stage 12-------------------------------------------

//-Stage 13------------------------------------------------

always @ (posedge clk) begin
	sub_output13 <= `Radius_fp - add_output12;
	radius_bool13 <= (add_output12 <= `Radius_fp ) ? 1 : 0;
end

//-End Stage 13-------------------------------------------

//-Stage 14------------------------------------------------

always @ (posedge clk) radius_bool14 <= radius_bool13;

//-End Stage 14-------------------------------------------

//-Stage 15------------------------------------------------

always @ (posedge clk) skinscore15 <= (radius_bool14) ? 0 : mult_output14;

//-End Stage 15-------------------------------------------

endmodule