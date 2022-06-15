function [y_bus, linedata, z_bus] = find_y_z_bus(linedata_file, sub_transient_data)

    linedata = readmatrix(linedata_file);
    x = readmatrix(sub_transient_data);
    [r_data,~] = size(linedata);
    [r_x,~] = size(x);
    for k=1:r_x
        if isnan(x(k,1))
            continue
        elseif x(k,1)~=0
            linedata(end+1,1) = x(k,1);
            linedata(end,2) = x(k,1);
            linedata(end,4) = x(k,2);
        end
    end
    
    
    % Preprocessing
    number_of_buses = max(max(linedata(:,1:2))); % picking the highest numbered bus
    y_bus = zeros(number_of_buses);
    [length_y_bus,~] = size(y_bus);
    
    % formatting the impedances
    R = linedata(:,3);
    X = linedata(:,4);
    B = linedata(:,5);
    impedances = [R X.*1i B*1i./2];
    
    % calculating the diagonal elements 
    for m=1:length_y_bus % m is the index of the y bus (row)
        z = zeros(1,3); % initialize 3 columns (R,X,B)
        for n=1:r_data % n is the index of the linedata (row)
            if linedata(n,1)==m||linedata(n,2)==m
                z = [z; linedata(n,3:5)]; % collecting all the impedances
            end
        end
        [r_z,~] = size(z);
        for impedance=1:r_z
            R = z(impedance,1);
            X = z(impedance,2);
            B = z(impedance,3);
            if R~=0 || X~=0
                y_bus(m,m) = y_bus(m,m) + 1./(R+X.*1i) + B.*1i/2;
            end
        end
    end
    
    % calculating off diagonal elements
    for m=1:length_y_bus % first index of Y element
        for n=1:length_y_bus % second index of Y element
            current_nodes = [m n];
            if m~=n
                for k=1:r_data
                    if linedata(k,1)==m && linedata(k,2)==n
                        R = linedata(k,3);
                        X = linedata(k,4);
                        B = linedata(k,5);
                        current_z = [R X B];
                        y_bus(m,n) = -1/(R+1i*X)+B*1i/2;
                        y_bus(n,m) = y_bus(m,n);
                    end
                end
            end
        end
    end
    % z bus calculation
    z_bus = y_bus^-1;
end