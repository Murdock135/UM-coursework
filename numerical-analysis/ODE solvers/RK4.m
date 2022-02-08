function [y, iterations] = RK4(f,x0,x_end,y0, h)

i = 1; %iteration
y(i) = y0; %initial condition
x(i) = x0; %initial condition


n = (x_end-x0)/h; %number of steps

for i=1:n
    k1(i) = f(  x(i),y(i)   );
    k2(i) = f(  x(i)+0.5*h, y(i)+0.5*k1(i)*h  );
    k3(i) = f(  x(i)+0.5*h, y(i)+0.5*k2(i)*h  );
    k4(i) = f(  x(i)+h, y(i)+k3(i)*h  );
    y(i+1) = y(i)+ h*(1/6)*(    k1(i) +2*k2(i)+ 2*k3(i)+ k4(i)     );
    x(i+1) = x(i) + h;
    i(i+1) = i+1;
end

iterations = i;