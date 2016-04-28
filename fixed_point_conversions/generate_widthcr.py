from settings import *

for i in range(2**8):
	Y = i
	output = 0

	if Y <= K_l:
		output = WL_Cr + (Y - Y_min)*(W_Cr - WL_Cr)/(K_l - Y_min)
	elif K_h <= Y:
		output = WH_Cr + (Y_max - Y)*(W_Cr - WH_Cr)/(Y_max - K_h)
	else:
		output = 0.0;

	if output != 0: 
		output = W_Cr / output		
		
	output = convert_to_fixed_point(output)

	if output == 0:
		print("0"*width)
	else:
		print("{:b}".format(output).zfill(width))