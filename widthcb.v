`include "datapath.vh"

module widthcb
(
	input		[7:0]					Y,
	output  	[`widthcb_width -1:0]	out
);

reg 	[`widthcb_width -1:0]	memory		[0:255];
reg 							y;

initial begin
	$readmemb("data/widthcb_data.txt", memory);
end

always @ (Y) begin
	y <= memory[Y];
end

endmodule
