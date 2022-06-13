clc;clear;
%% Standardizing generator sub-transient reactances
sb = 100; % MVA
s_old = [250 100 80 50 50]; % MVA

x1 = 15/100;
x2 = 12/100;
x3 = 10/100;
x4 = 9/100;
x5 = 8/100;
x = [x1 x2 x3 x4 x5];

% converting xolds to xnews
x = x.*100./s_old;

%% z bus calculation

Y_bus = find_y_bus('line_data.xlsx')
z_bus = inv(Y_bus);
% ali_y_bus = ali_findYmatrix('line_data.xlsx')
%% Q1 Sag calculation

