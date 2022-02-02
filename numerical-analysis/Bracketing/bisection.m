function root = bisection(f, xu, xl, es)
    fxl = f(xl);
    fxr = Inf;
    while abs(fxr)>es
        xr = (xu+xl)/2;
        fxr = f(xr)

        if xr==0
            break
        elseif fxr*fxl >0
            xl = xr;
        else
            xu = xr;
        end
    end
