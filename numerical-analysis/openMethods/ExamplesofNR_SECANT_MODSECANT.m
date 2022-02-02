%Example NR 1
syms x
f = x^2 - 6*x + 7;
derivF = diff(f);
guess = 0.5;

root = 0;
while root~=1.585
    
    mi = vpa(subs(derivF, x, guess));
    root = guess - vpa(subs(f, x, guess))/mi;
    guess = root
    error = 1.585-root;
    if error <= 0.005
        break
    end
end

root
    
%%
%Example NR-2

%Example NR 1
syms x
f = exp(-x)-x;
derivF = diff(f);
guess = 0;

root = 0;
while root~=1.585
    
    mi = vpa(subs(derivF, x, guess));
    root = guess - vpa(subs(f, x, guess))/mi;
    guess = root
    error = 1.585-root;
    if error <= 0.005
        break
    end
end

root
   
%% Another NR example

syms x
f = 3*x - 2*cos(x);
derivF = diff(f);

guess = pi/6;
i = 1;
while eval ~= 0
    mi = vpa(subs(derivF, x, guess));
    root = guess - vpa(subs(f, x, guess))/mi;
    guess = root;
    eval = vpa(subs(f, x, guess));
    error = abs(0-eval);
    if error <= 10e-10
        break
    end 
    i = i+1
end

root

%%
syms x
f = exp(-x)-x;

x1_old(1) = 0;
x2_old(1) = 1.0;
true_root = 0.56714;


i = 1;

while eval ~= 0
    f_x1(i) = vpa(subs(f, x, x1_old(i)));
    f_x2(i) = vpa(subs(f, x, x2_old(i)));
    x_new(i) = x1_old(i) - (f_x2(i)*(x1_old(i) - x2_old(i)))/(f_x1(i)-f_x2(i));
    eval(i) = vpa(subs(f, x, x_new(i)))
    error(i) = abs(0-eval(i))
    
    if error(i) <= 10e-3
        root = x_new(i)
        break
    else
        x2_old(i+1) = x_new(i);
        x1_old(i+1) = x2_old(i);
        i = i+1;
    end 
end
