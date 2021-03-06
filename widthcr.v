`include "datapath.vh"

module widthcr
(
	input		[7:0]					Y,
	output 		[`widthcr_width -1:0]	out
);

reg 	[`widthcr_width -1:0]	memory		[0:255];
reg 	[`widthcr_width -1:0]	y;

assign out = y;

initial $readmemb("data/widthcr_data.txt", memory);

always @ (Y) begin
	y <= memory[Y];
end

endmodule
