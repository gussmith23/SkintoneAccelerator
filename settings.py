W_Cb  = 46.97
WL_Cb =  23
WH_Cb =  14
W_Cr  = 38.76
WL_Cr =  20
WH_Cr =  10
K_l = 125
K_h = 188

Cx = 109.38
Cy = 152.02
Theta = 2.53
ECx = 1.60
ECy = 2.41
A = 25.39
B = 14.03
Y_min = 16
Y_max = 235

width = 16
frac_width = 8;
integer_width = width - frac_width - 1

def convert_to_fixed_point(a):
    num = a
    num = num * 2**frac_width
    num = int(num)
    mask = int('1'*width,2)
    num = num&mask

    return num
	
def format_fixed_point_num(a):
	bitstring = "{:b}".format(a);
	neg = a < 0
	#stopped here
	bitstring = bitstring.replace("-","")