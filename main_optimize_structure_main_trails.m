%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Authors: Ojha, Varun, Panto, B., and Nicosia G.
%  Incremental hypersphere algorithm for buckling analysis of space truss structures, 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

my_dir = pwd; % current directory
root = cd(my_dir); % change to current directory
addpath(genpath(my_dir)); % adapt path for convenience

warning('off'); % remove unnecessary printing of stuff
%%
%---------------------------------------------------
% define the structure
%---------------------------------------------------
nProblem = "Star"; % "EightMember"  "Star"  "Bridge"  "Arch"  "Dome"

disp([' Running ' nProblem]);
if (nProblem == "EightMember")
    SettingEigntMember;
elseif (nProblem == "Star")
    SetttingStar;
elseif (nProblem == "Bridge")
    SettingBridge;
elseif (nProblem == "Bridge2D")
    SettingBridge2D;
elseif (nProblem == "Arch")
    SettingArch;
elseif (nProblem == "Dome")
    SettingDome;
end

% Check the varaible setting
check_Min_Max = ["L", "C", "D"; nMin(1), nMin(conrolPointPos), nMin(2); nMax(1), nMax(conrolPointPos), nMax(2)];
disp(check_Min_Max)
%% Running the algorithm
% "DIRECT" or  "SA"  % Single objective algorithms
% "RandDE"  "BestDE" % Evolutionary Algorithms
% "ABC"  "ACO" "PSOStd" "PSOConst"  % swarm inspired algorithms

nAlgoName =  "RandDE";

% Check experiment setting
expSetting = "L"+string(loadLow)+"_"+string(loadHigh)+"C"+string(contolMinV)+"_"+string(contolMaxV)+"D"+string(nMinV)+"_"+string(nMaxV)+"";
disp(expSetting)

% analysis name setting -  automatically saves things in Data
expSavedTo = "Data/"+nProblem+"/"+nAlgoName+"/";
if ~exist(expSavedTo, 'dir')
    mkdir(expSavedTo)
end

K = 1000; % Thousand
% RUN THE ALGORITHM
% INPUT nStep number of trails for experiments
nStep=1;   % number of trails
for step=1:nStep
    expName  = strcat(nProblem,"_",nAlgoName,"_",expVersion,"_",expSetting,"_",datestr(now, 'yyyy-mm-dd HH-MM-SS'));
    %fprintf("\n Exp %s: L(%d %d) C(%d %d) D(%d %d):Step  %d : ",exprimentName, loadLow, loadHigh, contolMinV, contolMaxV, nMinV, nMaxV, step);
    fprintf("\n Exp %s: Step  %d : \n ",expName, step);
    
    % CALL ALGORITHM
    MaxIteration = 10*K;% Stopping Criteria 2 Stoping Critera 1, ie,  "tolarance" is set for each problem in their setting
    MaxPopulation = 50; % Population Size
    ConvergenceTolarance = 2000; % termination if not converging ie best solution change less than 10^-5 for that many itrations much
    
    % Printing iterations or not
    printStep = true;
    printStepLength = MaxIteration*(10/100);
    
    % Chose Algorithm - automatically
    if nAlgoName  == "SA"
        MaxPopulation = 1;
        sa_step;
    elseif nAlgoName == "DIRECT"
        %pattern_search_step;
        Call_Direct;
    elseif nAlgoName == "ABC"
        abc_step;
    elseif nAlgoName == "ACO"
        acor_step;
    elseif nAlgoName == "PSOStd"
        pso_step;
    elseif nAlgoName == "PSOConst"
        pso_step_constriction;
    elseif nAlgoName == "RandDE"
        de_step_rand_50K;
    elseif nAlgoName == "BestDE"
        de_step_best;
    end
    
    % Save results
    save(expSavedTo+expName+"_FinalPop.mat",'pop');
    save(expSavedTo+expName+"_BestSol.mat",'BestSol');
    save(expSavedTo+expName+"_BestCost.mat",'BestCost');
    
    % clear data
    clear pop;
    clear BestSol;
    clear BestCost;
    
    %break;
end