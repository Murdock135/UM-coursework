clc;clear;
%% Standardizing generator sub-transient reactances
sb = 100; % MVA
s_old = [250 100 80 50 50] % MVA

x1 = 15/100;
x2 = 12/100;
x3 = 10/100;
x4 = 9/100;
x5 = 8/100;
x = [x1 x2 x3 x4 x5]

% converting xolds to xnews
x = x.*100./s_old

%% Y bus calculation

% import data
linedata = readmatrix('line_data.xlsx');
impedances = linedata(:,3:5); % storing the impedances only
impedances(:,2) = impedances(:,2)*i;  % transforming into reactances
nodes = linedata(:,1:2); % storing the buses/nodes only
from_node = nodes(:,1);
to_node = nodes(:,2);

Y_bus = ones(14,14); % initializing the Y bus

for index1=1:length(from_node) % from nodes
    m = from_node(index1);
    if from_node(index1)==m

    end
end

% buses = 1:14;
% for bus=1:14
%     if bus~=from_node(bus)
%         from_node = [from_node; bus];
%     end
% end

% group linedata by from node
