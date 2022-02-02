function root = mod_secant(f,x0,del)
  es = 0.0001;
  ea(1) = Inf;
  
  i = 1;
  x(i) = x0;
  
  while abs(ea)>es
    if f(x(i))==0
      root = x(i);
      break
    end
    
    x(i+1) = x(i) - (del.*x(i).*f(x(i)))/(f(x(i)+del.*x(i))-f(x(i)));
    
    ea(i+1) = (f(x(i+1))-f(x(i)))/f(x(i+1)); 
    i = i+1;
    
    if i==100
      root = x(end);
      break
    end
    
    end
  
  root = x(end);
end

  
  