function [y_bus, linedata] = find_y_bus(linedata_file)

    linedata = readmatrix(linedata_file);
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
end