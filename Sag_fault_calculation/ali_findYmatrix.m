function Ymatrix= ali_findYmatrix(linedatafile)
linedata = readmatrix(linedatafile);
R= linedata(:,3);
X= linedata(:,4);
B= 1i*linedata(:,5);
Z = R+1i*X; % total line imepdence (real + imaginary)
Y= 1./Z;
 
LineLeftNode=linedata(:,1);
LineRightNode=linedata(:,2);
BusSize=max(max(LineLeftNode),max(LineRightNode));  %number of buses connected in the system
Ymatrix=zeros(BusSize,BusSize); %creating a matrix with dimensions BusSizexBusSize
LinesNum= length(linedata(:,1)); %Number of lines in the system (including connections between generator and buses)
 
for k= 1:LinesNum   %Y-matirx for non-diagnol admittance 
    if LineLeftNode(k) ~= 0 && LineRightNode(k) ~= 0 %excluding lines between buses and generators 
        Ymatrix(LineLeftNode(k),LineRightNode(k))=-Y(k);
        Ymatrix(LineRightNode(k),LineLeftNode(k))= Ymatrix(LineLeftNode(k),LineRightNode(k));
    end
end
for n1= 1:BusSize   %Y-Y matirx for diagnol admittance
    for n2 = 1:LinesNum
        if LineLeftNode(n2) == n1 || LineRightNode(n2) == n1 %given that impedence is seen by the bus, which can be Z21 or Z12 for bus 2.
            Ymatrix(n1,n1) = Ymatrix(n1,n1) + Y(n2) + B(n2)/2;
        end     
    end 
end
end