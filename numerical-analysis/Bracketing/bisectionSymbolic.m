function root = bisectionSymbolic(f, xu, xl, es)
    %this function will take a symbolic function,f, and perform bisection on it
    %with an initial bracket between [xl,xu] and keep performing bisection
    %until the percent relative error, ea(in this case, fxr), is less or equal to es(stopping
    %criteria).
    %
    %f is the function on which bisection will be performed
    %xu is the upper limit for performing bisection
    %xl is the lower limit
    %es is the stopping criteria


    %declaring the function
    x=sym('x');
    f(x)=f;
    
    %for plotting later
    xl_values = [];
    xu_values = [];
    xr_values = [];
    fxr_values = [];
    fxl_values = [];
    
    %performing bisection
    %precomputing fxl and setting fxr equal to infinity
    fxl = subs(f, x, xl);
    fxl_values(end+1) = fxl;
    fxr = Inf;
    iteration = 1;

    while abs(fxr)>es
        
        xr = (xu+xl)/2;
        xr_values(end+1) = xr; %putting xr into an array
        fxr = subs(f, x, xr);
        fxr_values(end+1) = fxr; %putting fxr into an array

        if xr==0
            disp('change xu and xl', 's');
            break
        elseif fxr*fxl >0
            xl = xr;
            fxl = fxr;

            xl_values(end+1) = xl;   
        elseif fxr*fxl<0
            xu = xr;
            xu_values(end+1) = xu;
        end
        fxl_values(end+1) = fxl;
        
        iteration = iteration +1;
    end
    root = xr;
    txt = sprintf('Bisection: root found at %.4f after %d iterations', root, iteration)

    %this part will plot the xl,xu,xr,fxl and fxr
    subplot(3,2,1)
    n = length(xl_values);
    x = linspace(0,30,n);
    plot(x, xl_values)
    title('xl')

    subplot(3,2,2)
    n = length(xu_values);
    x = linspace(0,200,n);
    plot(x, xu_values)
    title('xu')

    subplot(3,2,3)
    n = length(fxl_values);
    x = linspace(0,30,n);
    plot(x, fxl_values)
    title('fxl')

    subplot(3,2,4)
    n = length(fxr_values);
    x = linspace(0,30,n);
    plot(n, fxr_values)
    title('fxr')

    subplot(3,2,5)
    n = length(xr_values);
    x = linspace(0,30,n);
    plot(x, xr_values)
    title('xr')





    
    
