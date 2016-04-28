#ifndef _skintone_settings_h_
#define _skintone_settings_h_

#include <cmath>
#include <iostream>
#include <string>
#include <bitset>

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

double cos_t = -0.81873459927   ;
double sin_t = 0.57417214835    ;

double A2 = 644.6521            ;
double B2 = 196.8409            ;

double radius = 255             ;
double fac = 510                ;


const int width = 16;
const int frac_width = 7;
const int integer_width = width - frac_width - 1;

inline std::bitset<width> convert_to_fixed_point(double a)
{
	std::bitset<width> out = std::bitset<width>( (long int) (a * pow(2.0, (double)frac_width)) );
	if (a < 0.0f)
		out[width-1] = 1;
	
	return out;
}

inline double convert_from_fixed_point(std::bitset<width> a)
{
	int sign = a[width-1];
	a[width-1] = 0;
	double out = (double) a.to_ulong();
	out = out * pow(2.0, -1.0*((double)frac_width));
	if (sign) out = out * -1.0;
	
	return out;
}

#endif