function y_bus = find_y_bus(linedata)

    % import data as table
    linedata_table = readtable(linedata);
    y_bus = ones(14,14); % initializing the Y bus

    % Preprocessing for finding diagonal elements
    linedata_table.FromNode = categorical(linedata_table.FromNode);
    linedata_table.ToNode = categorical(linedata_table.ToNode);
    impedances = [linedata_table.R linedata_table.X linedata_table.B]; % storing the impedances only 
    impedances(:,2) = impedances(:,2)*i;  % transforming into reactances
    nodes = [linedata_table.FromNode linedata_table.ToNode]; % storing the buses/nodes only
    from_node = nodes(:,1);
    to_node = nodes(:,2);
    unique_from_nodes = unique(from_node);
    unique_to_nodes = unique(to_node);
    
    % calculating the diagonal elements 
    y_diag = eye(14,14);
    for m=1:length(unique_from_nodes)
        z = impedances(from_node==unique_from_nodes(m),:);
        y_diag(unique_from_nodes(m), unique_from_nodes(m)) = 1/(sum(z(:,1))+sum(z(:,2))+sum(z(:,3)));
    end
    
    % calculating off diagonal elements
    % preprocessing for calculating off diagonal elements
    linedata_matrix = readmatrix(linedata);
    nodes = linedata_matrix(:,1:2);
    y_off = zeros(14,14);
    impedances = impedances(:,1)+impedances(:,2)+impedances(:,3);
    [r,c] = size(linedata_matrix);
    
    
    for m=1:r
        y_off(nodes(m,1),nodes(m,2)) = -1/impedances(m);
    end

    y_bus = y_off + y_diag