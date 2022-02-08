function [y, iterations] = Euler(f,x0,x_end,y0, h)
%Euler(f,x0,x_end,y0,h) uses Euler's method and integrates an ODE, f from x0 to x_end using initial
%conditions t0 (independent var) and y0 (dependent var)

i = 1; %iteration
y(i) = y0; %initial condition
x(i) = x0; %initial condition

n = (x_end-x0)/h; %number of steps

for i=1:n
    y(i+1) = y(i)+h*f(x(i),y(i));
    x(i+1) = x(i)+h;
    i(i+1) = i+1;
end

%y = y(end);
iterations = i;
