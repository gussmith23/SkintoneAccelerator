`include "datapath.vh"

module meancb
(
	input		[7:0]					Y,
	output 		[`meancb_width -1:0]	out
);	

reg 	[`meancb_width -1:0]	memory		[0:255];
reg 	[`meancb_width -1:0]	y;

assign out = y;

initial $readmemb("data/meancb_data.txt", memory);

always @(Y) begin
	y <= memory[Y];
end

endmodule
