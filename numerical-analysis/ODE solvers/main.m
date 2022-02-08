clear all;

%use this script to test out all your functions for
%euler, heun, systems of linear equations, shooting, etc.

%% book example 25.1

f = @(x,y) -2*x^3 +12*x^2 -20*x + 8.5;

[Euler_r, Euler_i] = Euler(f,0,4,1,0.5);
[heun_r, heun_i] = heun(f,0,4,1,0.5);
[midpoint_r, midpoint_i] = midpoint(f,0,4,1,0.5);

figure(1)
plot(Euler_r)
hold on
plot(heun_r)
plot(midpoint_r)
legend

%% Book example 25.9 multivariable ODEs

f1 = @(y1,y2) -0.5*y1;
f2 = @(y1,y2) 4-0.3*y2-0.1*y1;

%% RK 2

f = @(x,y) -2*x^3 +12*x^2 -20*x + 8.5;

[RK2_mid_r, RK2_mid_i] = RK2(f,0,4,1, 0.5, 1);
[RK2_ral_r, RK2_ral_i] = RK2(f,0,4,1, 0.5, 2/3);
[RK2_heun_r, RK2_heun_i] = RK2(f,0,4,1, 0.5, 0.5);

figure(2)
plot(RK2_mid_r)
hold on
plot(RK2_ral_r)
plot(RK2_heun_r)
legend