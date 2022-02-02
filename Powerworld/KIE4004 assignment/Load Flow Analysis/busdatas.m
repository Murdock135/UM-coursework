function busdt = busdatas(~)
     
%         |Bus | Type | Vsp | theta | PGi | QGi | PLi | QLi | Qmin | Qmax |
busdt = [   1     1    1.06     0     0.0    0    0      0    -300   500;
            2     2    1.04     0   100.0    0    0      0    -200   300;
            3     2    1.05     0   110.0    0    0      0    -100   200;
            4     3    1.0      0     0.0    0  120     40       0     0;
            5     3    1.0      0     0.0    0   70     30       0     0;
            6     3    1.0      0     0.0    0   60     20       0     0];
