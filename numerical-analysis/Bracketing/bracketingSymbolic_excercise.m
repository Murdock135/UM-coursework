clear all;
close all;

x=sym('x');
f(x) = 4.*x.^3-6.*x.^2+7.*x-23;
root_bisection = bisectionSymbolic(f, 100,-150,0.1);

%%
f = @(x) 4.*x.^3-6.*x.^2+7.*x-23;
root_falsePosition = falsePosition(f,100,-150,0.1);
