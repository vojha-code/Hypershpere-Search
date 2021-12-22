%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA102
% Project Title: Implementation of Particle Swarm Optimization in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Particle Swarm Optimization in MATLAB (URL: https://yarpiz.com/50/ypea102-particle-swarm-optimization), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%


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


MaxIt = MaxIteration; %2000;  % Maximum Number of Iterations
nPop = MaxPopulation;        % Population Size

%% PSO Parameters
%w = 1;            % Inertia Weight
%wdamp = 0.99;     % Inertia Weight Damping Ratio
%c1 = 1.5;         % Personal Learning Coefficient
%c2 = 2.0;         % Global Learning Coefficient

% If you would like to use Constriction Coefficients for PSO, 
% uncomment the following block and comment the above set of parameters.

% % Constriction Coefficients
phi1 = 2.05;
phi2 = 2.05;
phi = phi1+phi2;
chi = 2/(phi-2+sqrt(phi^2-4*phi));
w = chi;          % Inertia Weight
wdamp = 1;        % Inertia Weight Damping Ratio
c1 = chi*phi1;    % Personal Learning Coefficient
c2 = chi*phi2;    % Global Learning Coefficient

% Velocity Limits
VelMax = 0.1*(VarMax-VarMin);
VelMin = -VelMax;

%% Initialization

empty_particle.Position = [];
empty_particle.Cost = [];
empty_particle.Velocity = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

particle = repmat(empty_particle, nPop, 1);

GlobalBest.Cost = inf;

for i = 1:nPop
    
    % Initialize Position
    particle(i).Position = unifrnd(VarMin, VarMax, VarSize);
    
    % Initialize Velocity
    particle(i).Velocity = zeros(VarSize);
    
    % Evaluation
    particle(i).Cost = CostFunction(particle(i).Position);
    
    % Update Personal Best
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    
    % Update Global Best
    if particle(i).Best.Cost<GlobalBest.Cost
        
        GlobalBest = particle(i).Best;
        
    end
    
end

BestCost = zeros(MaxIt, 1);

%% PSO Main Loop

checkConvergence = 0;

for it = 1:MaxIt
    
    for i = 1:nPop
        
        % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity, VelMin);
        particle(i).Velocity = min(particle(i).Velocity, VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Velocity Mirror Effect
        IsOutside = (particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside) = -particle(i).Velocity(IsOutside);
        
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position, VarMin);
        particle(i).Position = min(particle(i).Position, VarMax);
        
        % Evaluation
        particle(i).Cost = CostFunction(particle(i).Position);
        
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;
            
            % Update Global Best
            if particle(i).Best.Cost<GlobalBest.Cost
                if (abs( particle(i).Best.Cost - GlobalBest.Cost) > 0.00001)
                   checkConvergence = it; 
                end 
                GlobalBest = particle(i).Best;
                
            end
            
        end
        
    end
    
    BestCost(it) = GlobalBest.Cost;
    
    
    w = w*wdamp;
    
    %disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    if printStep && (mod(it,printStepLength)== 0 || it == 1)
        disp(['   Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    end
    
    % Show Iteration Information
    if (BestCost(it) < erroTolerance) || (it == MaxIt) || (abs(checkConvergence - it) > 20000)
        disp(['   Itr ' num2str(it) ': Best Cost = ' num2str(BestCost(it)), ' Break']);
        break;
    end
    
end

BestSol = GlobalBest;


%% Save results
pop = particle;
BestSol = GlobalBest;

%{
save(saveTo+exprimentName+"_FinalPop.mat",'particle');
save(saveTo+exprimentName+"_BestSol.mat",'GlobalBest');
save(saveTo+exprimentName+"_BestCost.mat",'BestCost');


figure;
%plot(BestCost, 'LineWidth', 2);
semilogy(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
%}

% clear data
clear particle;
clear GlobalBest; 

