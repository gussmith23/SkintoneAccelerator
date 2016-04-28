#include "settings.h"
#include <string>
#include <iostream>
#include <bitset>
#include <cmath>

#define DEBUG 0

int main()
{
	for (int i = 0; i < 256; i++)
	{
		double Y = i;
		double output = 0.0;
		
		if (Y < K_l) output = 108.0 + 10.0*(K_l - Y)/(K_l - Y_min);
		else if (K_h <= Y) output = 108.0 + 10.0*(Y - K_h)/(Y_max - K_h);
		else output = 0.0;
		
		if (DEBUG)	
			std::cout << "Should be: " << output << " is: " << convert_from_fixed_point(convert_to_fixed_point(output)) << std::endl;
		std::cout << convert_to_fixed_point(output).to_string() << std::endl;
	}
}