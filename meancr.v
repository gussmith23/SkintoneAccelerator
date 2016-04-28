`include "datapath.vh"

module meancr
(
	input		[7:0]					Y,
	output 		[`meancr_width -1:0]	out
);

reg 	[`meancr_width -1:0]	memory		[0:256];
reg 	[`meancr_width -1:0]	y;

assign out = y;

initial $readmemb("data/meancr_data.txt", memory);

always @(Y) begin
	y <= memory[Y];
end

endmodule
