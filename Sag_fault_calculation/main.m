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

%% Y bus calculation

% import data as table
linedata = readmatrix("line_data.xlsx");
y_bus = ones(14,14); % initializing the Y bus

% Preprocessing for finding diagonal elements
from_node = linedata(:,1);
to_node = linedata(:,2);
unique_from_nodes = unique(from_node);
unique_to_nodes = unique(to_node);
R = linedata(:,3);
X = linedata(:,4);
B = linedata(:,5);
impedances = [R X.*i B*i./2];


% calculating the diagonal elements 
y_diag = zeros(14,14);
for m=1:length(unique_from_nodes)
    z = impedances(from_node==unique_from_nodes(m)|to_node==unique_from_nodes(m),:);
    [r,c] = size(z);
    R = z(:,1);
    X = z(:,2);
    B = z(:,3);
    for k=1:r
        k;
        Y(k) = 1./(R(k)+X(k))
        y_diag(unique_from_nodes(m), unique_from_nodes(m)) = y_diag(unique_from_nodes(m), unique_from_nodes(m))+Y(k)+B(k);
    end 

end

% calculating off diagonal elements
% preprocessing for calculating off diagonal elements
nodes = linedata(:,1:2);
y_off = zeros(14,14);
impedances = impedances(:,1)+impedances(:,2);
[r,c] = size(linedata);


for m=1:r
    nodes(m,1)
    nodes(m,2)
    y_off(nodes(m,1),nodes(m,2)) = -1/impedances(m);
    y_off(nodes(m,2),nodes(m,1)) = y_off(nodes(m,1),nodes(m,2));
end

y_bus = y_off + y_diag;
%% z bus calculation
z_bus = y_bus^-1;

%% prefault voltages

v = readmatrix('voltages.xlsx'); % prefault voltages
v_magnitudes = v(:,1);
v_angles = deg2rad(v(:,2));

% converting to rectangular
vx = v_magnitudes.*cos(v_angles);
vy = v_magnitudes.*sin(v_angles);
v = vx+vy*i;

%% sags

%Calculate the voltage sag at bus 4 and bus 13 when a three-phase-fault occurs at each bus 
%in the system
fault_v4 = zeros(14,1);
fault_v13 = zeros(14,1);
for bus=1:14
    %if bus~=4|bus~=13
        fault_v4(bus) = (1-z_bus(4,bus)/z_bus(bus,bus))*v(bus);
        fault_v13(bus) = (1-z_bus(13,bus)/z_bus(bus,bus))*v(bus);
    %end
end

