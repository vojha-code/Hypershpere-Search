%---------------------------------------------------
% define the structure Sixteen_member_shallow
%---------------------------------------------------
if (nProblem == "Star")
    Sixteen_member_shallow;  % load + 15 dof from literature -  3d start
    
    erroTolerance = 10^-5;
    
    nVariables = 16; % [-20, 20]
    
    % load multiplier domain
    loadLow = -0.4; % -0.4 
    loadHigh = 0.85; %  0.8
    % general displacelemnt domain % 
    nMinV = -10;%-2.5;  % ( x 100) % -250; % these values are in mm
    nMaxV = 10;%0.1;    % 0 these values are in mm
    
    % control displacement domain position
    conrolPointPos = 4; 
    
    % control displacelemnt domain % 
    contolMinV =  -10;%-2.5 %-2.5; %  -250; % -250; % these values are in mm
    contolMaxV =  10;%0; % 0 these values are in mm
    
    
    
    % spacial displacement postion
    spacialDomain =  false;
    displacementPos = [6+1, 9+1, 12+1, 15+1];  % +1 for load multlier postion
    displacementMinV = -200;
    displacementMaxV = 50;
    
    expVersion = "expFull";
    nCostFun = "mulNone";
    %nCostFun = "mulNoneV2";
    
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
