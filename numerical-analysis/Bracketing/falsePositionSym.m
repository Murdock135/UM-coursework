function root = falsePosition(f,xu,xl,ea)
    fxl = f(xl);
    fxu = f(xu);
    fxr = Inf;
    iteration=1;

    while abs(fxr)>ea
        xr = (fxu*xl-fxl*fxu)/(fxu-fxl);
        fxr = f(xr);
        if fxl*fxu>0
            fprintf('there is no solution in the given interval')
            break
        elseif fxr==0
            break
        elseif fxr*fxl>0
            xl=xr;
            fxl=fxr;  
        else
            xu=xr;
            fxu=fxr;
        end
        iteration=iteration+1;
    end
    root=xr;
    sprintf('False Position: root found at %.4f after %d iterations', root,iteration)
