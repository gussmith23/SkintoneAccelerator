#include "settings.h"
#include <string>
#include <iostream>
#include <bitset>
#include <cmath>

void print_line(double a, std::string name)
{
	std::cout << "`define " << name << " " << width << "'b" << convert_to_fixed_point(a).to_string() << std::endl;
}

int main()
{
	print_line(-1.0*sin_t,		 	"neg_sint_fp");
	print_line(cos_t, 				"cost_fp");
	print_line(sin_t,				"sint_fp");
	print_line(1.0/A2,				"A2_inv_fp");
	print_line(1.0/B2,				"B2_inv_fp");
	print_line(fac, 				"fac_fp");
	print_line(Cx, 					"Cx_fp");
	print_line(Cy, 					"Cy_fp");
	print_line(ECx,					"ECx_fp");
	print_line(ECy,					"ECy_fp");
	print_line(radius, 				"Radius_fp");
}