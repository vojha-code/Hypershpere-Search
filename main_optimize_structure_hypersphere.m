%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Authors: Ojha Varun, Panto B, Nicosia G
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

nAlgoName =  "ACO";

% Check experiment setting
expSetting = "L"+string(loadLow)+"_"+string(loadHigh)+"C"+string(contolMinV)+"_"+string(contolMaxV)+"D"+string(nMinV)+"_"+string(nMaxV)+"";
disp(expSetting)

% analysis name setting -  automatically saves things in Data
expSavedTo = "Data/"+nProblem+"/"+nAlgoName+"/";
if ~exist(expSavedTo, 'dir')
    mkdir(expSavedTo)
end

%% Generate two trials sets first save them to a folder "FirstTwoTrails" in the Data folder
path = "Data/FirstTwoTrails";
listExp = dir(path);
fileBestSol = [];
bestSolDisp = [];
for file = 1: length(listExp)
    fileName = listExp(file).name;
    if(contains(fileName, "BestSol"))
        bestSol = load(fullfile(path, fileName)).BestSol;
        fileBestSol = [fileBestSol; bestSol];
        bestSolDisp = [bestSolDisp; bestSol.Position(4)];
    end
end

[val3, prev3] = min(bestSolDisp(1:5));
[val2, prev2] = min(bestSolDisp(6:10));
[val1, prev1] = min(bestSolDisp(11:15));

prev3 = fileBestSol(prev3);
prev2 = fileBestSol(prev2+5);
prev1 = fileBestSol(prev1+10);

% Verification
prev3.Position(4) == val3;
prev2.Position(4) == val2;
prev1.Position(4) == val1;

%%
P = [prev3.Position(1), prev3.Position(4)];
Q = [prev2.Position(1), prev2.Position(4)];
%%{
QP = [P(1)-Q(1), P(2)-Q(2)];
BestSolList = fileBestSol(11:15);
curCenterLength = 0;
curCenterIndex = 0;
for indexBest = 1:length(BestSolList)
    if BestSolList(indexBest).Cost < 0.0001
        lambda = BestSolList(indexBest).Position(1);
        contol = BestSolList(indexBest).Position(4);
        R = [lambda, contol];
        QR = [R(1)-Q(1), R(2)-Q(2)];
        a = [indexBest, contol, dot(QP,QR), norm(QR)];
        if dot(QP,QR) < 0
            if norm(QR) > curCenterLength
                curCenterLength = norm(QR);
                curCenterIndex = indexBest;
                
            end
        end
    end
end
P = [Q(1), Q(2)]; % set current Q as P
curCenter = BestSolList(curCenterIndex).Position;
Q = [curCenter(1), curCenter(4)]; % Update Q

nMin = curCenter-10;
nMax = curCenter+10;

nMin(1) = loadLow;% = -0.4; % -0.4
nMax(1) = loadHigh;% = 0.85; %  0.8

check_Min_Max = ["L", "C", "D"; nMin(1), nMin(conrolPointPos), nMin(2); nMax(1), nMax(conrolPointPos), nMax(2)]
expSetting = "L"+string(nMin(1))+"_"+string(nMax(1))+"C"+string(nMin(conrolPointPos))+"_"+string(nMax(conrolPointPos))+"D"+string(nMin(2))+"_"+string(nMax(2))+"";

%%
curControlMaxDist = 0;
radius = 10; % User defined hyper paramters
newBigSpace = 5;
trialBigEnable = 1;
%%
for radiousStep = 1:100
    % random experiments
    BestSolList = [];
    nStep=5;   % number of steps
    % RUN THE ALGORITHM
    for step=1:nStep
        expName  = strcat(nProblem,"_",nAlgoName,"_",expVersion,"_",expSetting,"_",datestr(now, 'yyyy-mm-dd HH-MM-SS'));
        %fprintf("\n Exp %s: L(%d %d) C(%d %d) D(%d %d):Step  %d : ",exprimentName, loadLow, loadHigh, contolMinV, contolMaxV, nMinV, nMaxV, step);
        fprintf("\n Exp %s: Step  %d : \n ",expName, step);
        
        % CALL ALGORITHM
        K = 1000;
        MaxIteration = 200*K;
        MaxPopulation = 50;
        
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
        
        BestSolList = [BestSolList; BestSol];
        % Save results
        save(expSavedTo+expName+"_FinalPop.mat",'pop');
        save(expSavedTo+expName+"_BestSol.mat",'BestSol');
        save(expSavedTo+expName+"_BestCost.mat",'BestCost');
        
        BestSol.Position(4)
        
        % clear data
        clear pop;
        clear BestSol;
        clear BestCost;
        
        %break;
        %end
    end
    
    % Crude trail if algorithm gets stuck 
    %{
    % find the max distance from the
    curControlMaxIndex = 0;
    for indexBest = 1:length(BestSolList)
        if BestSolList(indexBest).Cost < 0.0001
            BestSolList(indexBest).Position(4)
            if BestSolList(indexBest).Position(4) < curControlMaxDist
                curControlMaxIndex = indexBest;
                curControlMaxDist = BestSolList(indexBest).Position(4);
            end
        end
    end
    %}
    
    % Incremental hypershere search method 
    QP = [P(1)-Q(1), P(2)-Q(2)]; % vector from current center to previous one
    % processes serching next center
    curCenterLength = 0;
    curCenterIndex = 0;
    for indexBest = 1:length(BestSolList)
        if BestSolList(indexBest).Cost < 0.009
            lambda = BestSolList(indexBest).Position(1);
            contol = BestSolList(indexBest).Position(4);
            R = [lambda, contol];
            QR = [R(1)-Q(1), R(2)-Q(2)];
            %a = [indexBest, contol, dot(QP,QR), norm(QR)]
            if dot(QP,QR) < 0
                if norm(QR) > curCenterLength
                    curCenterLength = norm(QR);
                    curCenterIndex = indexBest
                end
            end
        end
    end
    
    if curCenterIndex == 0
        %if trailSmallEnable - trail experiments
        %   % stay at current center as search  slowley
        %    nMin = curCenter-radius/2; % reduce the search space radius by half
        %    nMax = curCenter+radius/2; % reduce the search space radius by half
        %    trailSmallEnable =  0;
        %    trialBigEnable = 0;
        %end
        if trialBigEnable %  - trail experiments
           % stay at current center as search  faster
           newBigSpace = newBigSpace + radius;
           nMin = curCenter-newBigSpace; % increase the search space radius
           nMax = curCenter+newBigSpace; % increase the search space radius
        end
    else
        trialBigEnable = 1;
        newBigSpace = 5;
        % update the current center
        curCenter = BestSolList(curCenterIndex).Position;
        P = [Q(1), Q(2)]; % set current Q as P
        Q = [curCenter(1), curCenter(4)] % Update Q
        % update search space
        nMin = curCenter-radius;
        nMax = curCenter+radius;
    end
    
    nMin(1) = loadLow;% = -0.4; % -0.4
    nMax(1) = loadHigh;% = 0.85; %  0.8
    
    check_Min_Max = ["L", "C", "D"; nMin(1), nMin(conrolPointPos), nMin(2); nMax(1), nMax(conrolPointPos), nMax(2)]
    expSetting = "L"+string(nMin(1))+"_"+string(nMax(1))+"C"+string(nMin(conrolPointPos))+"_"+string(nMax(conrolPointPos))+"D"+string(nMin(2))+"_"+string(nMax(2))+"";
    
    curControlMaxDist = curCenter(4);
    if curControlMaxDist < -250
        break;
    end
end