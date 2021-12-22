%{
clc;
clear all;
close all;

my_dir = pwd;
root = cd(my_dir);
addpath(genpath(my_dir));

warning('off');
%}
%%
%---------------------------------------------------
% define the structure
%---------------------------------------------------
if (nProblem == "Dome")
    
    Dome; % load  + n_gdl = 309 DoF
    
    erroTolerance = 10^-5;
    
    nVariables = n_gdl+1; % load +  309 dof
    
    
    % load multiplier domain (0, 100)
    loadLow = 1; % (x 100) 
    loadHigh = 10; % (x 100) 
    
    % general displacelemnt domain %  (-1000, 1000)
    nMinV = -100; % (x 100)  -2540; % these values are in mm  ; 
    nMaxV =  100; % (x 100) these values are in mm
    
    % control displacement domain position
    conrolPointPos = 4; 
    % control displacelemnt domain % 
    contolMinV =  nMinV; % -250; % these values are in mm
    contolMaxV =  nMaxV; % 0 these values are in mm
    
    expVersion = "expTest";
    nCostFun = "mulNoneV2"; % Cost Function
end


% variable domain setting
nMin = [loadLow, repelem(nMinV,nVariables-1)];
nMax = [loadHigh, repelem(nMaxV,nVariables-1)];

nMin(conrolPointPos) = contolMinV;
nMax(conrolPointPos) = contolMaxV;


%nMin
%nMax
%% Running the algorithm
%{
% analysis seting  
nStep=3;   % number of steps 

% analysis name setting
expVersion = "expFull"; % "exp1b"; "exp1b" "exp2a"; "exp2b"
settingType = "L"+string(loadLow)+"_"+string(loadHigh)+"C"+string(contolMinV)+"_"+string(contolMaxV)+"D"+string(nMinV)+"_"+string(nMaxV)+"";
algoName =  "BestDE"; % "RandDE" % "BestDE"

% RUN THE ALGORITHM
%for step=(nStep-0):nStep
for step=(nStep-0):nStep    
    exprimentName  = expVersion+"_"+settingType+"_"+nProblem+"_"+algoName+"_"+int2str(step);
    %fprintf("\n Exp %s: L(%d %d) C(%d %d) D(%d %d):Step  %d : ",exprimentName, loadLow, loadHigh, contolMinV, contolMaxV, nMinV, nMaxV, step);
    fprintf("\n Exp %s: Step  %d : \n",exprimentName, step);
    
    % CALL ALGORITHM
    K = 1000;
    MaxIteration = 1000*K;
    printStep = true;
    printStepLength = 10;
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