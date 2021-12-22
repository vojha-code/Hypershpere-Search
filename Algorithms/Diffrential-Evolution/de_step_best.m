%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA107
% Project Title: Implementation of Differential Evolution (DE) in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Differential Evolution (DE) in MATLAB (URL: https://yarpiz.com/231/ypea107-differential-evolution), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

%% Problem Definition

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

%% DE Parameters

MaxIt = MaxIteration; %2000;  % Maximum Number of Iterations
nPop = MaxPopulation;        % Population Size

beta_min = 0.2;%0.2;   % Lower Bound of Scaling Factor
beta_max = 0.8;%0.8;   % Upper Bound of Scaling Factor

pCR = 0.9;        % Crossover Probability

%% Initialization

empty_individual.Position = [];
empty_individual.Cost = [];

BestSol.Cost = inf;

pop = repmat(empty_individual, nPop, 1);

for i = 1:nPop

    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    
    pop(i).Cost = CostFunction(pop(i).Position);
    
    if pop(i).Cost<BestSol.Cost
        BestSol = pop(i);
    end
    
end

BestCost = zeros(MaxIt, 1);

%% DE Main Loop

checkConvergence = 0;

for it = 1:MaxIt
    
    for i = 1:nPop
        
        x = pop(i).Position;
        
        A = randperm(nPop);
        
        A(A == i) = [];
        
        a = A(1);
        b = A(2);
        c = A(3);
        d = A(4);
        
        % Mutation
        %beta = unifrnd(beta_min, beta_max);
        beta = unifrnd(beta_min, beta_max, VarSize);
        %y = pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        
        % best2bin, best2exp : Rank 1
        %y = BestSol.Position + beta.*(pop(r0).Position + pop(r1).Position - pop(r2).Position - pop(r3).Position);
        y = BestSol.Position + beta.*(pop(a).Position + pop(b).Position - pop(c).Position - pop(d).Position);
        
        y = max(y, VarMin);
		y = min(y, VarMax);
		
        % Crossover
        z = zeros(size(x));
        j0 = randi([1 numel(x)]);
        for j = 1:numel(x)
            if j == j0 || rand <= pCR
                z(j) = y(j);
            else
                z(j) = x(j);
            end
        end
        
        NewSol.Position = z;
        NewSol.Cost = CostFunction(NewSol.Position);
        
        if NewSol.Cost<pop(i).Cost
            pop(i) = NewSol;
            
            if pop(i).Cost<BestSol.Cost
               % check if the solution stuck in the local minima
               if (abs(pop(i).Cost - BestSol.Cost) > 0.00001)
                   checkConvergence = it; 
               end 
               BestSol = pop(i);
            end
        end
    end
    
    % Update Best Cost
    BestCost(it) = BestSol.Cost;
    if printStep && (mod(it,printStepLength)== 0 || it == 1)
        disp(['   Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    end
    
    % Show Iteration Information
    if (BestSol.Cost < erroTolerance) || (it == MaxIt) || (abs(checkConvergence - it) > 20000)
        disp(['   Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it)), ' Break']);
        break;
    end
end

%% Save results
%{
save(expSavedTo+expName+"_FinalPop.mat",'pop');
save(expSavedTo+expName+"_BestSol.mat",'BestSol');
save(expSavedTo+expName+"_BestCost.mat",'BestCost');

% clear data
clear pop;
clear BestSol; 
clear BestCost;
%}