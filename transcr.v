`include "datapath.vh"

module transcr
(
	input 								clk,
	input 		[7:0]					Cr,
	input 		[7:0]					Y,
	output		[`transcr_output - 1:0]	transcr
);

reg 		[7:0]					Cr0, Cr1, Cr2, Cr3, Cr4;
reg 		[7:0]					Y0;
reg									valid1, valid2, valid3, valid4;
wire 		[`meancr_width -1:0]	mean_output_wire;
reg signed 	[`meancr_width -1:0]	mean_output1;
wire 		[`widthcr_width -1:0]	width_output_wire;
reg signed	[`widthcr_width -1:0]	width_output1, width_output2;
reg	signed	[15:0]					sub_output2;
wire signed	[`fp_width - 1:0] 		mult_output3_wire;
reg signed	[`fp_width - 1:0]		mult_output3;
reg	signed	[15:0]					add_output4;
reg			[`transcr_output - 1:0]	transcr_reg;

assign transcr = transcr_reg;

meancr meancr_lut(
	.Y(Y0),
	.out(mean_output_wire)
);

widthcr widthcr_lut(
	.Y(Y0),
	.out(width_output_wire)
);

fp_mult mult_3(sub_output2, width_output2, mult_output3_wire);

///--STAGE 0-------------------------------

always @ (posedge clk) begin
	Cr0 <= Cr;
	Y0 <= Y;
end

///--STAGE 1-------------------------------

always @ (posedge clk) begin
	Cr1 <= Cr0;
	mean_output1 <= mean_output_wire;
	width_output1 <= width_output_wire;
	valid1 <= (`K_l<=Y && Y<=`K_h) ? 1 : 0;
end

///--STAGE 2-------------------------------

always @ (posedge clk) begin
	Cr2 <= Cr1;
	sub_output2 <= Cr1 - mean_output1;
	width_output2 <= width_output1;
	valid2 <= valid1;
end

///--STAGE 3-------------------------------

always @ (posedge clk) begin
	Cr3 <= Cr2;
	mult_output3 <= mult_output3_wire;
	valid3 <= valid2;
end

///--STAGE 4-------------------------------

always @ (posedge clk) begin
	Cr4 <= Cr3;
	add_output4 <= mult_output3[17:2] + `meancr_K_h;
	valid4 <= valid3;
end

///--OUTPUT-------------------------------

always @ (posedge clk) begin
	transcr_reg <= valid4 ? Cr4 : add_output4[15:8];
end

endmodule 
