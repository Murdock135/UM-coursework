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
linedata = readtable('line_data.xlsx');

% converting the node names into categorical type
linedata.FromNode = string(linedata.FromNode);
%linedata.ToNode = string(linedata.ToNode);
linedata.FromNode = categorical(linedata.FromNode);
linedata.ToNode = categorical(linedata.ToNode);

impedances = [linedata.R linedata.X linedata.B]; % storing the impedances only
impedances(:,2) = impedances(:,2)*i;  % transforming into reactances
nodes = [linedata.FromNode linedata.ToNode]; % storing the buses/nodes only
from_node = nodes(:,1);
to_node = nodes(:,2);

Y_bus = ones(14,14); % initializing the Y bus
unique_from_nodes = unique(from_node);
unique_to_nodes = unique(to_node);

% calculating the diagonal elements
y_diag = eye(14,14);
for m=1:length(unique(from_node))
    
    z = impedances(from_node==unique_from_nodes(m),:);
    y_diag(unique_from_nodes(m), unique_from_nodes(m)) = 1/(sum(z(:,1))+sum(z(:,2))+sum(z(:,3)));
end
