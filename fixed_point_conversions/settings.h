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


const int width = 32;
const int frac_width = 16;
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

inline double MeanCr(unsigned char Y)
{
	if(Y <= K_l)
		return 154.0 + 10.0*(K_l - Y)/(K_l - Y_min);
	else if(K_h <= Y)
		return 154.0 + 22.0*(Y - K_h)/(Y_max - K_h);
	else
		return 0.0;
}

inline double MeanCb(unsigned char Y)
{
	if(Y <= K_l)
		return 108 + 10*(K_l - Y)/(K_l - Y_min);
	else if(K_h <= Y)
		return 108 + 10*(Y - K_h)/(Y_max - K_h);
	else
		return 0.0;
}

inline double WidthCr(unsigned char Y)
{
	if(Y <= K_l)
		return WL_Cr + (Y - Y_min)*(W_Cr - WL_Cr)/(K_l - Y_min);
	else if(K_h <= Y)
		return WH_Cr + (Y_max - Y)*(W_Cr - WH_Cr)/(Y_max - K_h);
	else
		return 0.0;
}

inline double WidthCb(unsigned char Y)
{
	if(Y <= K_l)
		return WL_Cb + (Y - Y_min)*(W_Cb - WL_Cb)/(K_l - Y_min);
	else if(K_h <= Y)
		return WH_Cb + (Y_max - Y)*(W_Cb - WH_Cb)/(Y_max - K_h);
	else
		return 0.0;
}

inline double TransCr(unsigned char Y, unsigned char Cr)
{
	if( K_l <= Y && Y <= K_h)
		return Cr;
	else
		return (Cr - MeanCr(Y)) * (W_Cr / WidthCr(Y)) + MeanCr(K_h);
}

inline double TransCb(unsigned char Y, unsigned char Cb)
{
	if( K_l <= Y && Y <= K_h)
		return Cb;
	else
		return (Cb - MeanCb(Y)) * (W_Cb / WidthCb(Y)) + MeanCb(K_h);
}

#endif
