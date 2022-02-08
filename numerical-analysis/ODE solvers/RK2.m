function [y, iterations] = RK2(f,x0,x_end,y0, h, a2)

i = 1; %iteration
y(i) = y0; %initial condition
x(i) = x0; %initial condition


n = (x_end-x0)/h; %number of steps

a1 = 1-a2;
p1 = 0.5/a2;
q11 = 0.5/a2;


for i=1:n
    k1(i) = f(x(i),y(i));
    k2(i) = f(x(i)+p1*h,y(i)+q11*k1*h);
    y(i+1) = y(i)+ h*(a1*k1(i)+a2*k2(i));
    x(i+1) = x(i) + h;
    i(i+1) = i+1;
end

iterations = i;