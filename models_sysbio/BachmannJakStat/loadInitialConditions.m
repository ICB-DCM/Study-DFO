function D = loadInitialConditions(D,modeltype)
switch modeltype
    case {'reduced_woinit','reduced'}
        for cond = [1:6,15:numel(D)]
            D(cond).init = @(xi,u) [10.^xi(25);0;0;0;0;0;10.^xi(26);0;10.^xi(27);zeros(16,1)];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),0,0;
                zeros(5,27);
                zeros(1,25),10.^xi(26)*log(10),0;
                zeros(1,27);
                zeros(1,26),10.^xi(27)*log(10);
                zeros(16,27)];
        end
        for cond=11:12
            D(cond).init = @(xi,u) [10.^xi(25);0;0;0;0;0;10.^xi(26);0;10.^xi(27);zeros(15,1);u(3)*10.^(xi(15)+xi(16))];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),0,0;
                zeros(5,27);
                zeros(1,25),10.^xi(26)*log(10),0;
                zeros(1,27);
                zeros(1,26),10.^xi(27)*log(10);
                zeros(15,27)
                zeros(1,14), u(3)*10.^(xi(15)+xi(16))*log(10),u(3)*10.^(xi(15)+xi(16))*log(10),zeros(1,11)];
        end
        for cond=7:10
            D(cond).init = @(xi,u)   [10.^xi(25);0;0;0;0;u(2);10.^xi(26);0;10.^xi(27);zeros(8,1);u(2) * 10.^(xi(2)+xi(1)); zeros(7,1)];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),0,0;
                zeros(5,27);
                zeros(1,25),10.^xi(26)*log(10),0;
                zeros(1,27);
                zeros(1,26),10.^xi(27)*log(10);
                zeros(8,27);
                u(2)*log(10)*10.^(xi(2)+xi(1)),u(2)*log(10)*10.^(xi(2)+xi(1)),zeros(1,25);
                zeros(7,27)];
        end
        for cond = 13:14
            D(cond).init = @(xi,u)  [10.^xi(25);0;0;0;0;0;10.^xi(26)*(1+(u(4)*10.^xi(14)));0;10.^xi(27);zeros(16,1)];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),0,0;
                zeros(5,27);
                zeros(1,13),u(4)*10.^(xi(14)+xi(26))*log(10),zeros(1,11),10.^xi(26)*(1+(u(4)*10.^xi(14)))*log(10),0;
                zeros(1,27);
                zeros(1,26),10.^xi(27)*log(10);
                zeros(16,27)];
            
        end
        case {'foldchange'}
        for cond = [1:6,15:numel(D)]
            D(cond).init = @(xi,u) [10.^xi(25);0;0;0;0;0;10.^xi(26);0;10.^xi(27);zeros(16,1)];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),zeros(1,8);
                zeros(5,33);
                zeros(1,25),10.^xi(26)*log(10),zeros(1,7);
                zeros(1,33);
                zeros(1,26),10.^xi(27)*log(10),zeros(1,6);
                zeros(16,33)];
        end
        for cond=11:12
            D(cond).init = @(xi,u) [10.^xi(25);0;0;0;0;0;10.^xi(26);0;10.^xi(27);zeros(15,1);u(3)*10.^(xi(15)+xi(16))];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),zeros(1,8);
                zeros(5,33);
                zeros(1,25),10.^xi(26)*log(10),zeros(1,7);
                zeros(1,33);
                zeros(1,26),10.^xi(27)*log(10),zeros(1,6);
                zeros(15,33)
                zeros(1,14), u(3)*10.^(xi(15)+xi(16))*log(10),u(3)*10.^(xi(15)+xi(16))*log(10),zeros(1,17)];
        end
        for cond=7:10
            D(cond).init = @(xi,u)   [10.^xi(25);0;0;0;0;u(2);10.^xi(26);0;10.^xi(27);zeros(8,1);u(2) * 10.^(xi(2)+xi(1)); zeros(7,1)];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),zeros(1,8);
                zeros(5,33);
                zeros(1,25),10.^xi(26)*log(10),zeros(1,7);
                zeros(1,33);
                zeros(1,26),10.^xi(27)*log(10),zeros(1,6);
                zeros(8,33);
                u(2)*log(10)*10.^(xi(2)+xi(1)),u(2)*log(10)*10.^(xi(2)+xi(1)),zeros(1,31);
                zeros(7,33)];
        end
        for cond = 13:14
            D(cond).init = @(xi,u)  [10.^xi(25);0;0;0;0;0;10.^xi(26)*(1+(u(4)*10.^xi(14)));0;10.^xi(27);zeros(16,1)];
            D(cond).sinit = @(xi,u) [zeros(1,24),10.^xi(25)*log(10),zeros(1,8);
                zeros(5,33);
                zeros(1,13),u(4)*10.^(xi(14)+xi(26))*log(10),zeros(1,11),10.^xi(26)*(1+(u(4)*10.^xi(14)))*log(10),zeros(1,7);
                zeros(1,33);
                zeros(1,26),10.^xi(27)*log(10),zeros(1,6);
                zeros(16,33)];
            
        end
    case 'full'
        error('todo')
        for cond = [1:6,15:numel(D)]
            D(cond).init = @(xi,u) [10.^xi(27);0;0;0;0;0;10.^xi(28);0;10.^xi(29);zeros(16,1)];
            D(cond).sinit = @(xi,u) [zeros(1,26),10.^xi(27)*log(10),0,0;
                zeros(5,29);
                zeros(1,29),10.^xi(28)*log(10),0;
                zeros(1,29);
                zeros(1,28),10.^xi(29)*log(10);
                zeros(16,29)];
        end
end