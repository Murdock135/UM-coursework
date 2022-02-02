% Program for Newton-Raphson Load Flow Analysis..
% Ref Book: Power System Analysis by Hadi Saadat..
tic
num = 6;                    % IEEE-6
Y = ybusppg(num);           % Calling ybusppg.m to get Bus Admittance Matrix..
busd = busdatas(num);       % Calling busdatas.m to get busdata..
BMva = 100;                 % Base MVA..
bus = busd(:,1);            % Bus Number..
type = busd(:,2);           % Type of Bus 1-Slack, 2-PV, 3-PQ..
V = busd(:,3);              % Specified Voltage..
del = zeros(length(V),1);   % Voltage Angle..
Pg = busd(:,5)/BMva;        % PGi..
Qg = busd(:,6)/BMva;        % QGi..
Pl = busd(:,7)/BMva;        % PLi..
Ql = busd(:,8)/BMva;        % QLi..
Qmin = busd(:,9)/BMva;      % Minimum Reactive Power Limit..
Qmax = busd(:,10)/BMva;     % Maximum Reactive Power Limit..
nbus = max(bus);            % To get no. of buses..
P = Pg - Pl;                % Pi = PGi - PLi..
Q = Qg - Ql;                % Qi = QGi - QLi..
Psp = P;                    % P Specified       
Qsp = Q;                    % Q Specified
G = real(Y);                % Conductance..
B = imag(Y);                % Susceptance..

pv = find(type == 2 | type == 1);   % Index of PV Buses..
pq = find(type == 3);               % Index of PQ Buses..
npv = length(pv);                   % Number of PV buses..
npq = length(pq);                   % Number of PQ buses..

Tol = 1;
Iter = 1;

while (Tol > 1e-5)          % Iteration starting..
    P = zeros(nbus,1);
    Q = zeros(nbus,1);
    % Calculate P and Q
    for i = 1:nbus
        for k = 1:nbus
            P(i) = P(i) + V(i)* V(k)*(G(i,k)*cos(del(i)-del(k)) + B(i,k)*sin(del(i)-del(k)));
            Q(i) = Q(i) + V(i)* V(k)*(G(i,k)*sin(del(i)-del(k)) - B(i,k)*cos(del(i)-del(k)));
        end
    end

    % Checking Q-limit violations..
    if Iter <= 7 && Iter > 2        % Only checked up to 7th iterations..
        for n = 2:nbus
            if type(n) == 2
                QG = Q(n)+Ql(n);
                if QG < Qmin(n)
                    V(n) = V(n) + 0.01;
                elseif QG > Qmax(n)
                    V(n) = V(n) - 0.01;
                end
            end
         end
    end
    
    % Calculate change from specified value
    dPa = Psp-P;
    dQa = Qsp-Q;
    k = 1;
    dQ = zeros(npq,1);
    for i = 1:nbus
        if type(i) == 3
            dQ(k,1) = dQa(i);
            k = k+1;
        end
    end
    dP = dPa(2:nbus);
    M = [dP; dQ];       % Mismatch Vector
    
    % Jacobian
    % J1 - Derivative of Real Power Injections with Angles..
    J1 = zeros(nbus-1,nbus-1);
    for i = 1:(nbus-1)
        m = i+1;
        for k = 1:(nbus-1)
            n = k+1;
            J1(i,k)=imag(Y(m,n))*-V(m);
        end
    end
    
    % J2 - Derivative of Real Power Injections with V is negligible..
    J2 = zeros(nbus-1,npq);

    % J3 - Derivative of Reactive Power Injections with Angles is negligible..
    J3 = zeros(npq,nbus-1);
    
    % J4 - Derivative of Reactive Power Injections with V..
    J4 = zeros(npq,npq);
    for i = 1:npq
        m = pq(i);
        for k = 1:npq
            n = pq(k);
            J4(i,k)=imag(Y(m,n))*-V(m);
        end
    end
    
    J = [J1 J2; J3 J4];     % Jacobian Matrix
    
    X = J\M;                % INV(J) x M, Correction Vector..
    dTh = X(1:nbus-1);      % Change in Voltage Angle..
    dV = X(nbus:end);       % Change in Voltage Magnitude..
    
    % Update State Vectors (Voltage Angle & Magnitude)
    del(2:nbus) = dTh + del(2:nbus);
    k = 1;
    for i = 2:nbus
        if type(i) == 3
            V(i) = dV(k) + V(i);
            k = k+1;
        end
    end
    Iter = Iter + 1;
    Tol = max(abs(M));
end

% Call Load Flow
[Pi,Qi,Pg,Qg,Pij,Qij,Lpij,Lqij] = loadflow(num,V,del,BMva);      
toc

fprintf('No. of Iterations = %g \n', Iter)
fprintf('Maximum Power Mismatch = %g \n\n\n', Tol)

disp('#########################################################################################');
disp('-----------------------------------------------------------------------------------------');
disp('                              Fast Decouple Load flow Analysis ');
disp('-----------------------------------------------------------------------------------------');
Output(num,V,del,Pi,Qi,Pg,Qg,Pij,Qij,Lpij,Lqij)