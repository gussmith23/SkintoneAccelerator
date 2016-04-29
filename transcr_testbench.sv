`include "datapath.vh" 	 

module transcr_testbench();

class Cr_Y_pair;
	rand bit[15:0] pair;
endclass;

reg 							clk;
reg 		[7:0]					Cr;
reg 		[7:0]					Y;
wire		[`transcr_output - 1:0]	transcr;

Cr_Y_pair pair;

real widthcr_y;
real meancr_y;
real meancr_kh;
real actual_transcr;
real found_transcr;

transcr dut(clk, Cr, Y, transcr);


function meancr_func;
input reg [7:0] Y;
begin
if (Y <= `K_l )
  meancr_func = 154.0 + 10.0*(`K_l - Y)/(`K_l - `Y_min);
else if (`K_h <= Y)
  meancr_func = 154.0 + 22.0*(Y - `K_h)/(`Y_max - `K_h);
else meancr_func = 0.0;
end
endfunction


function widthcr_func;
input reg [7:0] Y;
begin
if (Y <= `K_l )
  widthcr_func = `WL_Cr + (Y - `Y_min)*(`W_Cr - `WL_Cr)/(`K_l - `Y_min);
else if (`K_h <= Y)
  widthcr_func = `WH_Cr + (`Y_max - Y)*(`W_Cr - `WH_Cr)/(`Y_max - `K_h);
else widthcr_func = 0.0;
end
endfunction

function transcr_func;
input reg [7:0] Y;
input reg [7:0] Cr;
begin
if (`K_l <= Y && Y <= `K_h)
  transcr_func = $itor(Cr);
else
  transcr_func = (Cr - meancr_func(Y)) * (`W_Cr / widthcr_func(Y)) + meancr_func(`K_h);
end
endfunction


initial begin
	$monitor("%b\t%b\t%f\t%f", Cr, Y, found_transcr, actual_transcr);
	clk = 0;
	pair = new();
end

always #5 begin
	clk = !clk;
	pair.randomize();
	Cr = pair.pair[15:8];
	Y = pair.pair[7:0];
	
        actual_transcr = transcr_func(Y, Cr);

	/*	
	// Calculate meancr_y
	if(Y <= `K_l )
		meancr_y = 154.0 + 10.0*(`K_l - Y)/(`K_l - `Y_min );
	else if( `K_h <= Y)
		meancr_y = 154.0 + 22.0*(Y - `K_h )/(`Y_max - `K_h );
	else
		meancr_y = 0.0;
		
	// Calculate meancr_kh
	if(`K_h <= `K_l )
		meancr_kh = 154.0 + 10.0*(`K_l - `K_h )/(`K_l - `Y_min );
	else if( `K_h <= `K_h )
		meancr_kh = 154.0 + 22.0*(`K_h - `K_h )/(`Y_max - `K_h );
	else
		meancr_kh = 0.0;
		
	// Calculate widthcr_y
	if(Y <= `K_l )
		widthcr_y = `WL_Cr + (Y - `Y_min )*(`W_Cr - `WL_Cr )/(`K_l - `Y_min );
	else if(`K_h <= Y)
		widthcr_y = `WH_Cr + (`Y_max -  Y)*(`W_Cr - `WH_Cr )/(`Y_max - `K_h );
	else
		widthcr_y = 0.0;
	
	// Calculate actual_transcr
	if (`K_l <= Y && Y <= `K_h )
		actual_transcr =  Cr;
	else
		actual_transcr = (Cr - meancr_y) * (`W_Cr / widthcr_y) + meancr_kh;
	*/	
end

always @ (transcr) begin
	convert_from_fixed(transcr, found_transcr);
end

always #1000 $finish();
endmodule
