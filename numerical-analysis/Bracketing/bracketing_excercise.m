clear all;
close all;

f=@(x) 4.*x.^3-6.*x.^2+7.*x-23;
bisection(f,1,0,0.1)