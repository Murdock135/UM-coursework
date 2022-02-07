function [yc, iterations] = heun(f,x0,x_end,y0, h)
%heun(f,t0,y0,b1,b2) integrates an ODE, f from x0 to x_end using initial
%conditions t0 (independent var) and y0 (dependent var)

i = 1; %iteration
yc(i) = y0; % corrected y value
x(i) = x0; %initial condition
yp(i) = 0; %predicted y value

n = (x_end-x0)/h;

for i=1:n
    yp(i+1) = yc(i) + h*f(x(i),yc(i));
    x(i+1) = x(i)+h;
    yc(i+1) = yc(i) + (h/2)*(f(x(i),yc(i))+f(x(i+1),yp(i+1)));
    i(i+1) = i+1;
end

%y = y(end);
iterations = i;