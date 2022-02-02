 clear all; close all;
 f = @(x) x^2-5*x+10;
 del = 0.3;
 x0 = -10;
 
 es = 0.0001;
 ea(1) = Inf;
  
 i = 1;
 x(i) = x0;i
 
 while abs(ea)>es
    x(end+1) = x(i) - (del*f(x(i)))/(f(x(i)+del)-f(x(i)));
    
    ea(i+1) = (f(x(i+1))-f(x(i)))/f(x(i+1)); 
    i = i+1;
 endwhile
  
  root = x(end);