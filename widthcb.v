`include "datapath.vh"

module widthcb
(
	input		[7:0]	Y,
	output reg			out
);

reg 	[`widthcb_width -1:0]	memory		[0:256];
reg 				y;

initial begin
	$readmemb("data/widthcb_data.txt", memory);
end

always begin
	y <= memory[Y];
end

endmodule
