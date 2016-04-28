from settings import *

for i in range(2**8):
	Y = i
	output = 0
	if Y <= K_l:
		output = 154.0 + 10.0*(K_l - Y)/(K_l - Y_min)
	elif K_h <= Y:
		output = 154.0 + 22.0*(Y - K_h)/(Y_max - K_h)
	else:
		output = 0

	output = convert_to_fixed_point(output)

	if output == 0:
		print("0"*width)
	else:
		print("{:b}".format(output).zfill(width))


    
