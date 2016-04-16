`include "datapath.h"

module transcr
(
	input 			clk,
	input 		[7:0]	Cr,
	input 		[7:0]	Y,
	output	reg	[7:0]	transcr
);

wire 	[`meancr_width -1:0]	mean_output_wire;
wire 	[`widthcr_width -1:0]	width_output_wire;

reg 	[7:0]			Cr0, Cr1, Cr2, Cr3, Cr4;
reg 	[7:0]			Y0;
reg				valid1, valid2, valid3, valid4;
reg 	[`meancr_width -1:0]	mean_output1;
reg 	[`widthcr_width -1:0]	width_output1, width_output2;
reg	[15:0]			sub_output2;
reg 	[31:0]			mult_output3;
reg	[15:0]			add_output4;


meancr meancr_lut(
	.Y(Y0),
	.out(mean_output)
);

widthcr widthcr_lut(
	.Y(Y0),
	.out(width_output)
);

///--STAGE 0-------------------------------

always @ (posedge clk) begin
	Cr0 <= Cr;
	Y0 <= Y;
end

///--STAGE 1-------------------------------

always @ (posedge clk) begin
	Cr1 <= Cr0;
	mean_output1 <= mean_output;
	width_output1 <= width_output;
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
	mult_output3 <= sub_output2 * width_output2;
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
	transcr <= valid4 ? Cr4 : add_output4[15:8];
end

endmodule 