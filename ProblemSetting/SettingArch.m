%%
%---------------------------------------------------
% define the structure
%---------------------------------------------------
%nProblem = "arch"; %"bridge"  "2dstart"  "arch"
if (nProblem == "Arch")
    
    Arch; % load + 80 DoF
    
    erroTolerance = 10^-5;
    
    nVariables = n_gdl+1; % 81; %[-30, 30]
    
    % load multiplier domain
    loadLow = -0.8;
    loadHigh = 0.8;
    
    % general displacelemnt domain % 
    nMinV = -100; % -900; % these values are in mm
    nMaxV =  0; % 0 these values are in mm
    
    % control displacement domain position
    conrolPointPos = 5; 
    % control displacelemnt domain % 
    contolMinV = nMinV; % -900; % these values are in mm
    contolMaxV = nMaxV; % 0 these values are in mm
    
    % spacial displacement postion
    spacialDomain =  false;
    displacementPos = [4]; % u(3)=Sol(5)= 0 
    displacementMinV = 0;
    displacementMaxV = 0;
    
    expVersion = "expTest";
    %  Cost Function use cost that modifies disp only
    nCostFun = "mulNoneV2"; % This depends on how you set variables
end


% variable domain setting
nMin = [loadLow, repelem(nMinV,nVariables-1)];
nMax = [loadHigh, repelem(nMaxV,nVariables-1)];

nMin(conrolPointPos) = contolMinV;
nMax(conrolPointPos) = contolMaxV;

if spacialDomain
    nMin(displacementPos) = displacementMinV;
    nMax(displacementPos) = displacementMaxV;
end

%{
%nMin
%nMax
%% Running the algorithm

% analysis seting  
nStep=1;   % number of steps 

% analysis name setting
expVersion = "expFull"; % "exp1b"; "exp1b" "exp2a"; "exp2b"
settingType = "L"+string(loadLow)+"_"+string(loadHigh)+"C"+string(contolMinV)+"_"+string(contolMaxV)+"D"+string(nMinV)+"_"+string(nMaxV)+"";
algoName =  "BestDE"; % "RandDE" % "BestDE"

% RUN THE ALGORITHM
for step=(nStep-0):nStep
    exprimentName  = expVersion+"_"+settingType+"_"+nProblem+"_"+algoName+"_"+int2str(step);
    %fprintf("\n Exp %s: L(%d %d) C(%d %d) D(%d %d):Step  %d : ",exprimentName, loadLow, loadHigh, contolMinV, contolMaxV, nMinV, nMaxV, step);
    fprintf("\n Exp %s: Step  %d : \n",exprimentName, step);
    
    % CALL ALGORITHM
    K = 1000;
    MaxIteration = 100*K;
    printStep = true;
    printStepLength = 100;
    % Chose Algorithm
    if algoName == "RandDE"
        de_step_org; % RANDOM DE
    else
        de_step_best; % BEST DE
    end
    %pso_step;
    
    %break;
end

%}