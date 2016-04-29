#include "settings.h"
#include <string>
#include <iostream>
#include <bitset>
#include <cmath>

#define DEBUG 1

// TODO the last line generated with this script is in error using Q9.6

int main()
{
	for (int i = 0; i < 256; i++)
	{
		double Y = i;
		double output = 0.0;
		
		if (Y < K_l) output = WL_Cb + (Y - Y_min)*(W_Cb - WL_Cb)/(K_l - Y_min);
		else if (K_h <= Y) output = WH_Cb + (Y_max - Y)*(W_Cb - WH_Cb)/(Y_max - K_h);
		else output = 0.0;
		
		if (output != 0.0)	output = W_Cb / output;
		
		if (DEBUG)	
			std::cout << "Should be: " << output << " is: " << convert_from_fixed_point(convert_to_fixed_point(output)) << std::endl;
		std::cout << convert_to_fixed_point(output).to_string() << std::endl;
	}
}
