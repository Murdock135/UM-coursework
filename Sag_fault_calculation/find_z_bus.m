function [z_bus, gen_reactances] = find_z_bus(y_bus,gen_reactances_xlsx)
    z_bus = y_bus^-1;
    gen_reactances = readmatrix(gen_reactances_xlsx);

    % convert reactances to the appropriate base MVA

    [r,c] = size(gen_reactances);
    
%     for k=1:r
%         node = gen_reactances(k,1);
%         z_bus(node,node) = z_bus(node,node) + gen_reactances(k,)



