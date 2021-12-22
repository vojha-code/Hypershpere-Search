%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA106
% Project Title: Real-Coded Simulated Annealing in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Real-Coded Simulated Annealing (SA) in MATLAB (URL: https://yarpiz.com/421/ypea106-real-coded-simulated-annealing), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

%CostFunction = @(x) Sphere(x);    % Cost Function
if nCostFun == "mulNone"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_Org(x,step,R,Tol_R,Tol_dir); % 
elseif nCostFun == "mulDisp"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_M100Disp(x,step,R,Tol_R,Tol_dir); % Cost Function
elseif nCostFun == "mulAll"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_M100All(x,step,R,Tol_R,Tol_dir); % Cost Function 
elseif nCostFun == "mulNoneV2"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1V2(x,step,R,Tol_R,Tol_dir);     % Cost Function
elseif nCostFun == "mulDispV2"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_M100DispV2(x,step,R,Tol_R,Tol_dir);     % Cost Function
elseif nCostFun == "mulAllV2"
    disp([' Running ' nCostFun]);
    CostFunction = @(x) ObjSOP1_M100DispV2(x,step,R,Tol_R,Tol_dir);     % Cost Function
end

nVar = nVariables;            % Number of Decision Variables

VarSize = [1 nVar];   % Decision Variables Matrix Size

%VarMin = nMinV;          % Lower Bound of Decision Variables
%VarMax = nMaxV;          % Upper Bound of Decision Variables

% use full vector
VarMin = nMin;          % Lower Bound of Decision Variables
VarMax = nMax;          % Upper Bound of Decision Variables


MaxIt = MaxIteration; %2000;  % Maximum Number of Iterations
nPop = MaxPopulation;        % Population Size


%% SA Paramters

MaxSubIt = 1;    % Maximum Number of Sub-iterations

T0 = 0.1;       % Initial Temp.

alpha = 0.99;     % Temp. Reduction Rate



nMove = 5;        % Number of Neighbors per Individual

mu = 0.5;       % Mutation Rate

sigma = 0.1*(VarMax-VarMin);    % Mutation Range (Standard Deviation)

%% Initialization

% Create Empty Structure for Individuals
empty_individual.Position = [];
empty_individual.Cost = [];

% Create Population Array
pop = repmat(empty_individual, nPop, 1);

% Initialize Best Solution
BestSol.Cost = inf;

% Initialize Population
for i = 1:nPop
    
    % Initialize Position
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    
    % Evaluation
    pop(i).Cost = CostFunction(pop(i).Position);
    
    % Update Best Solution
    if pop(i).Cost <= BestSol.Cost
        BestSol = pop(i);
    end
    
end

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

% Intialize Temp.
T = T0;

%% SA Main Loop

for it = 1:MaxIt
    
    for subit = 1:MaxSubIt
        
        % Create and Evaluate New Solutions
        newpop = repmat(empty_individual, nPop, nMove);
        for i = 1:nPop
            for j = 1:nMove
                
                % Create Neighbor
                newpop(i, j).Position = MutateInd(pop(i).Position, mu, sigma, VarMin, VarMax);
                
                % Evaluation
                newpop(i, j).Cost = CostFunction(newpop(i, j).Position);
                
            end
        end
        newpop = newpop(:);
        
        % Sort Neighbors
        [~, SortOrder] = sort([newpop.Cost]);
        newpop = newpop(SortOrder);
        
        for i = 1:nPop
            
            if newpop(i).Cost <= pop(i).Cost
                pop(i) = newpop(i);
                
            else
                DELTA = (newpop(i).Cost-pop(i).Cost)/pop(i).Cost;
                P = exp(-DELTA/T);
                if rand <= P
                    pop(i) = newpop(i);
                end
            end
            
            % Update Best Solution Ever Found
            if pop(i).Cost <= BestSol.Cost
                BestSol = pop(i);
            end
        
        end

    end
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;
    
    
    % Update Temp.
    T = alpha*T;
    
    sigma = 0.98*sigma;
    
    % Display Iteration Information
    if printStep && (mod(it,printStepLength)== 0 || it == 1)
        disp(['   Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    end
    
    % Show Iteration Information
    if (BestSol.Cost < erroTolerance) || (it == MaxIt) %|| (abs(checkConvergence - it) > 20000)
        disp(['  Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
        break;
    end
    
end

%% Save results
%%{
save(saveTo+exprimentName+"_FinalPop.mat",'pop');
save(saveTo+exprimentName+"_BestSol.mat",'BestSol');
save(saveTo+exprimentName+"_BestCost.mat",'BestCost');

figure;
plot(BestCost, 'LineWidth', 2);
semilogy(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

% clear data
clear pop;
clear BestSol; 
clear BestCost;
%}