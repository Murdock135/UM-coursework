clear all; close all;

%This part of the code is for debugging purposes
g = @(x) x^2-4;
slope = @(x) 2*x;

mod_secant_root_g = mod_secant(g,100,0.001)
NR_root_g = newton_raphson(g,-3,slope)

%%

% The following are the constants that are used in the function to be solved via newton_raphson 
% the slope function to be used in newton_raphson and are obtained from reference []
% It is recommended to read the function f at line 26 first, then the slope function at line 27, and then these variables.

q = 1.6*10e-19;
A = 1.3;
K = 1.38*10e-23;
T = 25+273;
Voc = 0.591667;
Isc = 7.82;
vt = (A*K*T)/q;
io = 1.6234*10e-7;

f = @(v) Isc + io.*(1-((v/vt)+1).*exp(v/vt));
slope_f = @(v) -io*(exp(v/vt)/vt + (exp(v/vt)*(v/vt + 1))/vt);

[root, iterations, error] = newton_raphson(f,17,slope_f);