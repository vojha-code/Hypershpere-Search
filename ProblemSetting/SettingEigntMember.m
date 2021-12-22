%---------------------------------------------------
% structure setting 8 member
%---------------------------------------------------
if (nProblem == "EightMember")
    disp([' Running ' nProblem]);
    Eight_Member_Symmetric_Shallow_Truss; % lambda + 3 Dof from literature
    
    erroTolerance = 10^-5;
    
    nVariables = 4; % 1 labda + 3 Dof
    
    % load multiplier domain (- 0.2, 0.4) 
    loadLow = -0.2; % -0.2
    loadHigh = 1; % 1
    
    % general displacelemnt domain % (-2540, 0)
    nMinV = -2; % (x100) -3000 % these values are in mm  ; 
    nMaxV =  0; % (x 100) 0 these values are in mm
    
    % control displacement domain position
    conrolPointPos = 4; 
    % control displacelemnt domain % 
    contolMinV = -30; % (x100) -3000; % these values are in mm
    contolMaxV =  -0;  % (x100) these values are in mm
    nCostFun = "mulDisp";
    
    expVersion = "expFull"; % "exp1b"; "exp1b" "exp2a"; "exp2b" 
end

% variable domain setting
nMin = [loadLow, repelem(nMinV,nVariables-1)];
nMax = [loadHigh, repelem(nMaxV,nVariables-1)];

nMin(conrolPointPos) = contolMinV;
nMax(conrolPointPos) = contolMaxV;

nMin
nMax

%{
%% Running the algorithm

% analysis seting  
nStep=700;   % number of steps 

% analysis name setting
expVersion = "expFull"; % "exp1b"; "exp1b" "exp2a"; "exp2b"
settingType = "L"+string(loadLow)+"_"+string(loadHigh)+"C"+string(contolMinV)+"_"+string(contolMaxV)+"D"+string(nMinV)+"_"+string(nMaxV)+"";
algoName =  "BestDE"; % "RandDE" % "BestDE"

% RUN THE ALGORITHM
%for step=(nStep-0):nStep
for step=601:nStep    
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