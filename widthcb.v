`include "datapath.h"

module widthcb
(
	input	[7:0]	Y,
	output out
);

reg 	[`widthcb_width -1:0]	memory		[0:256];
reg 				y;

initial begin
	$readmemb("widthcb_data.txt", memory);
end

always begin
	y <= memory[Y];
end

endmodule