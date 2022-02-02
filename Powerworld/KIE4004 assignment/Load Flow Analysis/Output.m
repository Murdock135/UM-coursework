% Program for Bus Power Injections, Line & Power flows (p.u)...
function Output(num,V,del,Pi,Qi,Pg,Qg,Pij,Qij,Lpij,Lqij)

% Program for Bus Power Injections, Line & Power flows (p.u)...

lined = linedatas(num);
busd = busdatas(num);
Vm = pol2rect(V,del);       % Converting polar to rectangular..
Del = 180/pi*del;           % Bus Voltage Angles in Degree...
fb = lined(:,1);            % From bus number...
tb = lined(:,2);            % To bus number...
nl = length(fb);            % No. of Branches..
Pl = busd(:,7);             % PLi..
Ql = busd(:,8);             % QLi..
nb = length(Vm);            % Number of buses

disp('| Bus |    V   |  Angle  |     Injection      |     Generation     |          Load      |');
disp('| No  |   pu   |  Degree |    MW   |   MVar   |    MW   |  Mvar    |     MW     |  MVar | ');

for m = 1:nb
    disp('-----------------------------------------------------------------------------------------');
    fprintf('%3g', m); fprintf('  %8.4f', V(m)); fprintf('   %8.4f', Del(m));
    fprintf('  %8.2f', Pi(m)); fprintf('   %8.2f', Qi(m)); 
    fprintf('  %8.2f', Pg(m)); fprintf('   %8.2f', Qg(m)); 
    fprintf('  %8.2f', Pl(m)); fprintf('   %8.2f', Ql(m)); fprintf('\n');
end

disp('-----------------------------------------------------------------------------------------');
fprintf(' Total                  ');fprintf('  %8.3f', sum(Pi)); fprintf('   %8.3f', sum(Qi)); 
fprintf('  %8.3f', sum(Pi+Pl)); fprintf('   %8.3f', sum(Qi+Ql));
fprintf('  %8.3f', sum(Pl)); fprintf('   %8.3f', sum(Ql)); fprintf('\n');
disp('-----------------------------------------------------------------------------------------');
disp('#########################################################################################');

disp('-------------------------------------------------------------------------------------');
disp('                              Line Flow and Losses ');
disp('-------------------------------------------------------------------------------------');
disp('|From|To |    P    |    Q     | From| To |    P     |   Q     |      Line Loss      |');
disp('|Bus |Bus|   MW    |   MVar   | Bus | Bus|    MW    |  MVar   |     MW   |    MVar  |');

for m = 1:nl
    p = fb(m); q = tb(m);
    disp('-------------------------------------------------------------------------------------');
    fprintf('%4g', p); fprintf('%4g', q); fprintf('  %8.2f', Pij(p,q)); fprintf('   %8.2f', Qij(p,q)); 
    fprintf('   %4g', q); fprintf('%4g', p); fprintf('   %8.2f', Pij(q,p)); fprintf('   %8.2f', Qij(q,p));
    fprintf('  %8.2f', Lpij(m)); fprintf('   %8.2f', Lqij(m));
    fprintf('\n');
end

disp('-------------------------------------------------------------------------------------');
fprintf('   Total Loss                                                 ');
fprintf('  %8.3f', sum(Lpij)); fprintf('   %8.3f', sum(Lqij));  fprintf('\n');
disp('-------------------------------------------------------------------------------------');
disp('#####################################################################################');