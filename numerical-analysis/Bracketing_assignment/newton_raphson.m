function [root, iterations, error] = newton_raphson(f,x0,slope_function)
  %newton_raphson(f, x0, slope_function): 
  %The function takes an input function f, an intial guess from 15-20 (this
  %is crucial to be maintained), and a slope function. And produces the
  %root of function f, the number of iterations and the absolute value of
  %the approximate relative error, error.
  %
  %the function will also produce plots for the guesses, the function
  %value, the slope value and the error at each iteration


  es = 0.001; %stopping criteria
  ea = Inf; %the approximate relative error is initiated at infinity.
  
  i = 1;

  %the intial guess provided by the user is recorded.
  x(i) = x0;
  
  %the following loop will iterate as long as absolute value of ea is
  %greater than the stopping criteria.
  while abs(ea)>es
    %the base condition: if the function at the guess value is 0, the guess is itself the root.  
    if f(x(i))==0
      root = x(i);
      break
    end
    
    %the new guess is calculated as per NR equation
    x(i+1) = x(i) - f(x(i))/slope_function(x(i));
    %the new approximate relative error is recorded
    ea(i+1) = (f(x(i+1))-f(x(i)))/f(x(i+1));
    i = i+1;
    
    %it is hypothesized that iterations greater than 100 will not
    %significantly improve the guess and the error.
    if (i==100)
      root = x(end);
      break
    end
  end
  
  %the last element of the array, x, is the root
  root = x(end);
  %the final i value is actually one more than the number of iterations in
  %the while loop. hence,
  iterations = i-1;
  %the error is the absolute value of the last element of the array, ea.
  error = abs(ea(end));

  %the following section produces the plots for the guesses, the function
  %value, and the error at each iteration
   
  %first, computing f(x) for every value of x and storing each value of
  %f(x)
  
  for i=1:numel(x) %reusing i since we don't need i in the end
      F(i) = f(x(i));
  end

  i = 1:numel(x); %reusing i
 
   subplot(3,1,1)
   plot(i,x)
   title('iteration vs x(i)')
   hold on
   plot(i(end),root, 'ro')
 
   subplot(3,1,2)
   plot(i,ea)
   title('iteration vs error')

   subplot(3,1,3)
   plot(i,F)
   title('iteration vs f(xi)')

end

