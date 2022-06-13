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
linedata_table = readtable('line_data.xlsx');
%% Setting up the data for processing

% converting the node names into categorical type
linedata_table.FromNode = categorical(linedata_table.FromNode);
linedata_table.ToNode = categorical(linedata_table.ToNode);

impedances = [linedata_table.R linedata_table.X linedata_table.B]; % storing the impedances only

impedances(:,2) = impedances(:,2)*i;  % transforming into reactances
nodes = [linedata_table.FromNode linedata_table.ToNode]; % storing the buses/nodes only
from_node = nodes(:,1);
to_node = nodes(:,2);

Y_bus = ones(14,14); % initializing the Y bus
unique_from_nodes = unique(from_node);
unique_to_nodes = unique(to_node);

%% calculating the diagonal elements
% 
y_diag = eye(14,14);
for m=1:length(unique_from_nodes)
    z = impedances(from_node==unique_from_nodes(m),:);
    y_diag(unique_from_nodes(m), unique_from_nodes(m)) = 1/(sum(z(:,1))+sum(z(:,2))+sum(z(:,3)));
end

%% calculating off diagonal elements

% preprocessing
linedata_matrix = readmatrix("line_data.xlsx");
nodes = linedata_matrix(:,1:2);
y_off = zeros(14,14);
impedances = impedances(:,1)+impedances(:,2)+impedances(:,3);
[r,c] = size(linedata_matrix);


for m=1:r
    y_off(nodes(m,1),nodes(m,2)) = -1/impedances(m);
end

Y_bus = y_off + y_diag;

