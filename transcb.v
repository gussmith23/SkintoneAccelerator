`include "datapath.vh"

module transcb
(
	input 								clk,
	input 			[7:0]					Cb,
	input 			[7:0]					Y,
	output signed	[`transcb_output - 1:0]	transcb
);

reg 		[7:0]					Cb0, Cb1, Cb2, Cb3, Cb4;
reg 		[7:0]					Y0;
reg									valid1, valid2, valid3, valid4;
wire signed	[`meancb_width -1:0]	mean_output_wire;
reg signed	[`meancb_width -1:0]	mean_output1;
wire signed	[`widthcb_width -1:0]	width_output_wire;
reg signed	[`widthcb_width -1:0]	width_output1, width_output2;
reg	signed	[`fp_width - 1:0]		sub_output2;
wire signed	[`fp_width - 1:0] 		mult_output3_wire;
reg signed	[`fp_width - 1:0] 		mult_output3;
reg	signed	[`fp_width - 1:0]		add_output4;
reg	signed	[`transcb_output - 1:0]	transcb_reg;

assign transcb = transcb_reg;

meancr meancb_lut(
	.Y(Y0),
	.out(mean_output_wire)
);

widthcr widthcb_lut(
	.Y(Y0),
	.out(width_output_wire)
);

fp_mult mult_3(sub_output2, width_output2, mult_output3_wire);

///--STAGE 0-------------------------------

always @ (posedge clk) begin
	Cb0 <= Cb;
	Y0 <= Y;
end

///--STAGE 1-------------------------------

always @ (posedge clk) begin
	Cb1 <= Cb0;
	mean_output1 <= mean_output_wire;
	width_output1 <= width_output_wire;
	valid1 <= (`K_l<=Y && Y<=`K_h) ? 1 : 0;
end

///--STAGE 2-------------------------------

always @ (posedge clk) begin
	Cb2 <= Cb1;
	sub_output2 <= Cb1 - mean_output1;
	width_output2 <= width_output1;
	valid2 <= valid1;
end

///--STAGE 3-------------------------------

always @ (posedge clk) begin
	Cb3 <= Cb2;
	mult_output3 <= mult_output3_wire;
	valid3 <= valid2;
end

///--STAGE 4-------------------------------

always @ (posedge clk) begin
	Cb4 <= Cb3;
	add_output4 <= mult_output3 + `meancb_K_h;
	valid4 <= valid3;
end

///--OUTPUT-------------------------------

always @ (posedge clk) begin
	transcb_reg <= valid4 ? Cb4 : add_output4;
end

endmodule 
