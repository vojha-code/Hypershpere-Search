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

clc;
clear;
close all;

warning('off')
%% Problem Definition

Benchmark1;   %30 dof not from literature

CostFunction = @(x) Sphere(x);    % Cost Function
%CostFunction = @(x) arch_obj(x,nStep,R,Tol_R,Tol_dir,n_gdl);    % Cost Function

nVar = 30;            % Number of Decision Variables

VarSize = [1 nVar];   % Decision Variables Matrix Size

VarMin = -10;          % Lower Bound of Decision Variables
VarMax = 10;          % Upper Bound of Decision Variables

%% DE Parameters

MaxIt = 1000;      % Maximum Number of Iterations

nPop = 10;        % Population Size

beta_min = 0.2;   % Lower Bound of Scaling Factor
beta_max = 0.8;   % Upper Bound of Scaling Factor

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

for it = 1:MaxIt
    
    for i = 1:nPop
        
        % trail vector
        x = pop(i).Position;
        
        % vector of randm index of individual in the population
        A = randperm(nPop);
        % removing current (ith) solution
        A(A == i) = [];
        
        % choosing three solutions
        r0 = A(1);
        r1 = A(2);
        r2 = A(3);
        r3 = A(4);
        r4 = A(5);
        
        %error('stop')
        
        % Mutation
        beta = unifrnd(beta_min, beta_max, VarSize);
        
        % best1bin, best1exp : Rank 3
        %y = BestSol.Position + beta.*(pop(r0).Position - pop(r1).Position);
        
        % best2bin, best2exp : Rank 1
        y = BestSol.Position + beta.*(pop(r0).Position + pop(r1).Position - pop(r2).Position - pop(r3).Position);
        
        % rand1bin, rand1exp : Rank 2
        %y = pop(r0).Position + beta.*(pop(r1).Position - pop(r2).Position);
        
        % rand2bin, rand2exp : Rank 5
        %y = pop(r0).Position + beta.*(pop(r1).Position + pop(r2).Position - pop(r1).Position - pop(r2).Position);
        
        % currentToBest1bin, currenttobest1exp  : Rank 2 (or better)
        %y = pop(i).Position + beta.*(BestSol.Position - pop(i).Position + pop(r0).Position - pop(r1).Position);
        
        
        % randtobest1bin, randtobest1exp  : Rank 4
        %y = pop(r0).Position + beta.*(BestSol.Position - pop(r0).Position) + beta.*(pop(r1).Position - pop(r2).Position);
        
        % JADE
        %y = pop(i).Position + beta.*(BestSol.Position - pop(i).Position) + beta.*(pop(r0).Position - pop(r1).Position);
        
        
        % Checking bound
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
               BestSol = pop(i);
            end
        end
        
    end
    
    % Update Best Cost
    BestCost(it) = BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%{ 
% Save results
save("BestSol_all.mat",'BestSol')
save("BestCost_all.mat",'BestCost')
%% Show Results
disp('best cost:');
BestSol.Cost
disp('best solution:');
%}

%%{
figure;
%plot(BestCost);
semilogy(BestCost, 'LineWidth', 2, 'Color', 'k');
xlabel('Optimization Generations');
ylabel('Equilibrium');
grid on;
%}
