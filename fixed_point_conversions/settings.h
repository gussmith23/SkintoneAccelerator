#include <cmath>
#include <iostream>
#include <string>

double W_Cb  = 46.97            ;
double WL_Cb =  23              ;
double WH_Cb =  14              ;
double W_Cr  = 38.76            ;
double WL_Cr =  20              ;
double WH_Cr =  10              ;
double K_l = 125                ;
                        
double K_h = 188                ;
double Cx = 109.38              ;
double Cy = 152.02              ;
double Theta = 2.53             ;
double ECx = 1.60               ;
double ECy = 2.41               ;
double A = 25.39                ;
double B = 14.03                ;
double Y_min = 16               ;
double Y_max = 235              ;

int width = 16;
int frac_width = 8;
int integer_width = width - frac_width - 1;


inline long int convert_to_fixed_point(double a)
{
    a = a * pow(2.0, (double)frac_width);
    return (long int) a;
}

inline std::string get_bits(long int a, int num_to_print)
{
	std::string out;
	
	for (int i = 0; i < num_to_print; i++)
		out += ((a >> i)&1) == 0 ? "0" : "1";
	
	return out;
}