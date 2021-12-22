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
%%
%  Discreete domain setting to try
clc;
discreteBoxSize = 20;

for step=1:1%:nStep
    upLow =  -discreteBoxSize;
    upHigh =  discreteBoxSize;
    for control=1:floor(abs(nMinV)/discreteBoxSize)
        fprintf("\n Try domain %d  = (%d, %d)",control, upLow,upHigh);
        % updated the domain
        upLow = upLow - discreteBoxSize;
        upHigh = upHigh - discreteBoxSize;
    end
end
%}

%%
% variable domain setting
nMin = [loadLow, repelem(nMinV,nVariables-1)];
nMax = [loadHigh, repelem(nMaxV,nVariables-1)];

nMin(conrolPointPos) = contolMinV;
nMax(conrolPointPos) = contolMaxV;

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

K = 1000; % Thousand
% RUN THE ALGORITHM
% INPUT nStep number of trails for experiments
nStep=50;   % number of trails

%% Response vector
%U(n_gdl,nStep)=0;
%%{ 
% experiment of _damon completed
already_done = 20;
discite_domain_step = 20;
%
for step=1:nStep
    upLow = -discite_domain_step-already_done;
    upHigh = 0-already_done;
    for control=1:floor(abs(nMinV)/discite_domain_step)
        fprintf("\n Try domain %d  = (%d, %d)",control, upLow,upHigh);
        %fprintf("\n Exp Domain %d  %d: ",control, step);

        % ADAPTIVE DOMAIN
        nMin = [loadLow, repelem(upLow,nVariables-1)];
        nMax = [loadHigh, repelem(upHigh,nVariables-1)];

        % CALL ALGORITHM
        de_step; % checne it for algorithm you want
        
        % UPDATE THE DOMAIN
        upLow = upLow - discite_domain_step;
        upHigh = upHigh - discite_domain_step;
        %break;
    end
    %break;
end
save("Data/cLambda_RandDE_"+nProblem+".mat",'Lambda');
save("Data/cU_RandDE_"+nProblem+".mat",'U');

%}


