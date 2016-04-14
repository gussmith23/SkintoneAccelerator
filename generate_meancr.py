K_l = 125
K_h = 188
Y_min = 16
Y_max = 235

integer_width = 8;
frac_width = 8;
width = integer_width+frac_width

def convert_to_fixed_point(a):
    num = a
    num = num * 2**frac_width
    print(num)
    num = int(num)
    print(num)
    mask = int('1'*width,2)
    num = num&mask

    return num

for i in range(2**8):
    Y = i
    output = 0
    if Y <= K_l:
        output = 154.0 + 10.0*(K_l - Y)/(K_l - Y_min)
    elif K_h <= Y:
        output = 154.0 + 22.0*(Y - K_h)/(Y_max - K_h)
    else:
        output = 0

    print(output)
    output = int(output)
    output = convert_to_fixed_point(output)

    if output == 0:
        print("0"*width)
    else:
        print("{:b}".format(output).zfill(width))


    
