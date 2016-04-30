#include "settings.h"
#include <string>
#include <iostream>
#include <bitset>
#include <cmath>

#define DEBUG 0

// TODO error increases significantly at the end.
// NOTE: Like the other file, this code isn't generating WidthCb but W_Cb/WidthCb. 

int main()
{
	for (int i = 0; i < 256; i++)
	{
		double Y = i;
		double output = W_Cb / WidthCb(Y);
		
		if (DEBUG)	
			std::cout << "Should be: " << output << " is: " << convert_from_fixed_point(convert_to_fixed_point(output)) << std::endl;
		std::cout << convert_to_fixed_point(output).to_string() << std::endl;
	}
}
