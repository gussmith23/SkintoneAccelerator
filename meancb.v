`include "datapath.h"

module meancb
(
	input	[7:0]	Y,
	output out
);

reg 	[`meancb_width -1:0]	memory		[0:256];
reg 	[`meancb_width -1:0]	y;

assign out = y;

initial begin
	$readmemb("meancb_data.txt", memory);
end

always begin
	y <= memory[Y];
end

endmodule