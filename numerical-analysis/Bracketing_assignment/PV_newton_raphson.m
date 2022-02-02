function [x_root, y_root, ea_abs] = PV_newton_raphson(f,x0,y0, slope_function)
  es = 0.001;
  ea(1) = Inf;
  
  i = 1;
  x(i) = x0;
  y(i) = y0;
  
  while abs(ea)>es
    if f(x(i),y(i))==0
      x_root = x(i);
      y_root = y(i);
      break
    endif
    
    
    x(i+1) = x(i) - f(x(i),y(i))/slope_function(x(i),y(i));
    y(i+1) = y(i)+0.001;
    ea(i+1) = (f(x(i+1),y(i+1))-f(x(i),y(i)))/f(x(i+1),y(i+1));
    i = i+1;
    
    
    
    if (i==100)
      x_root = x(end);
      y_root = y(end);
      break
    endif
  endwhile
  
  x_root = x(end);
  y_root = y(end);
  ea_abs = abs(ea(end));
end
