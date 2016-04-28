`include "datapath.vh"

module widthcr
(
	input		[7:0]	Y,
	output reg 			out
);

reg 	[`widthcr_width -1:0]	memory		[0:256];
reg 				y;

initial begin
	$readmemb("data/widthcr_data.txt", memory);
end

always begin
	y <= memory[Y];
end

endmodule
