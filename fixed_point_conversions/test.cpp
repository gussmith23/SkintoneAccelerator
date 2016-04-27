#include "settings.h"
#include <string>
#include <iostream>
#include <bitset>

int main()
{
	double a = -21.241243124;
	
	double b = 128.123123;
	
	double c = convert_from_fixed_point(std::bitset<width>(convert_to_fixed_point(a).to_ulong() + convert_to_fixed_point(b).to_ulong()));
	
	std::cout << convert_to_fixed_point(a).to_string() << " + " << convert_to_fixed_point(b).to_string() << " = " << convert_to_fixed_point(c).to_string() << std::endl;	
	std::cout << a << " + " << b << " = " << c << std::endl;	

}