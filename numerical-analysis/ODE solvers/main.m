%use this script to test out all your functions for
%euler, heun, systems of linear equations, shooting, etc.

%book example 25.1
f = @(x,y) -2*x^3 +12*x^2 -20*x + 8.5;

Euler_r = Euler(f,0,4,1,0.5)
