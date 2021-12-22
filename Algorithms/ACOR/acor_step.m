%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA104
% Project Title: Ant Colony Optimization for Continuous Domains (ACOR)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, ACO for Continuous Domains in MATLAB (URL: https://yarpiz.com/67/ypea104-acor), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

%clc;
%clear;
%close all;

%% Problem Definition
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


MaxIt = MaxIteration;   %2000;  % Maximum Number of Iterations
nPop = MaxPopulation;        % Population Size



%% ACOR Parameters

nSample = 40; %40         % Sample Size

q =  0.5;%'85; %0.5;              % Intensification Factor (Selection Pressure)

zeta = 1;             % Deviation-Distance Ratio

%% Initialization

% Create Empty Individual Structure
empty_individual.Position = [];
empty_individual.Cost = [];

% Create Population Matrix
pop = repmat(empty_individual, nPop, 1);

% Initialize Population Members
for i = 1:nPop
    
    % Create Random Solution
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    
    % Evaluation
    pop(i).Cost = CostFunction(pop(i).Position);
    
end

% Sort Population
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);

% Update Best Solution Ever Found
BestSol = pop(1);

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

% Solution Weights
w = 1/(sqrt(2*pi)*q*nPop)*exp(-0.5*(((1:nPop)-1)/(q*nPop)).^2);

% Selection Probabilities
p = w/sum(w);


%% ACOR Main Loop

for it = 1:MaxIt
    
    % Means
    s = zeros(nPop, nVar);
    for l = 1:nPop
        s(l, :) = pop(l).Position;
    end
    
    % Standard Deviations
    sigma = zeros(nPop, nVar);
    for l = 1:nPop
        D = 0;
        for r = 1:nPop
            D = D+abs(s(l, :)-s(r, :));
        end
        sigma(l, :) = zeta*D/(nPop-1);
    end
    
    % Create New Population Array
    newpop = repmat(empty_individual, nSample, 1);
    for t = 1:nSample
        
        % Initialize Position Matrix
        newpop(t).Position = zeros(VarSize);
        
        % Solution Construction
        for i = 1:nVar
            
            % Select Gaussian Kernel
            l = RouletteWheelSelection(p);
            
            % Generate Gaussian Random Variable
            newpop(t).Position(i) = s(l, i)+sigma(l, i)*randn;
            
        end
        
        % Apply Variable Bounds
        newpop(t).Position = max(newpop(t).Position, VarMin);
        newpop(t).Position = min(newpop(t).Position, VarMax);
        
        % Evaluation
        newpop(t).Cost = CostFunction(newpop(t).Position);
        
    end
    
    % Merge Main Population (Archive) and New Population (Samples)
    pop = [pop
         newpop]; %#ok
     
    % Sort Population
    [~, SortOrder] = sort([pop.Cost]);
    pop = pop(SortOrder);
    
    % Delete Extra Members
    pop = pop(1:nPop);
    
    % Update Best Solution Ever Found
    BestSol = pop(1);
    
    % Store Best Cost
    BestCost(it) = BestSol.Cost;
    
    % Show Iteration Information
    %disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    if printStep && (mod(it,printStepLength)== 0 || it == 1)
        disp(['   Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    end
    
    % Show Iteration Information
    if (BestSol.Cost < erroTolerance) || (it == MaxIt) %|| (abs(checkConvergence - it) > 20000)
        disp(['Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
        break;
    end
end

%% Save results
%{
save(saveTo+exprimentName+"_FinalPop.mat",'pop');
save(saveTo+exprimentName+"_BestSol.mat",'BestSol');
save(saveTo+exprimentName+"_BestCost.mat",'BestCost');


figure;
%plot(BestCost, 'LineWidth', 2);
semilogy(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

% clear data
clear pop;
clear BestSol; 
clear BestCost;
%}