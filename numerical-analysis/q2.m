clear all;

x = 0.5;
n = 0;
f(n+1) = [x];
ea(n+1) = Inf;
es = 0.05;

while abs(ea)>es
    f(n+2) = -1^n*(x^(n+1)/(n+1))+f(n+1);
    ea(n+2) = (f(n+2)-f(n+1))/(f(n+2));
    n=n+1;
    iteration(n)=n;
end
disp(f(end))
iteration(end+1)=6;
subplot(2,1,1);
plot(iteration,f)

subplot(2,1,2)
plot(iteration, ea)