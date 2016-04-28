from settings import *

print(makeDefine("Cx_fp", convert_to_fixed_point(Cx)))

def makeDefine(name,a):
	#return "`define " + "{:b}".format(a).zfill(width)