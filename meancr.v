`include "datapath.h"

module meancr
(
	input	[7:0]	Y,
	output out
);

reg 	[`meancr_width -1:0]	memory		[0:256];
reg 	[`meancr_width -1:0]	y;

assign out = y;

initial begin
	$readmemb("meancr_data.txt", memory);
end

always begin
	y <= memory[Y];
end

endmodule