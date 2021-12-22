%---------------------------------------------------
% define the structure
%---------------------------------------------------
if (nProblem == "Bridge")
    Benchmark1;      %  load +   30 dof not from literature - bridge
    erroTolerance = 10^-4;
    
    nVariables = 31;% 31; % 1 load + 30 DoF
    
    
    % load multiplier domain (0 900)
    loadLow = 0; % (x 100) 
    loadHigh = 9; % (x 100) 
    
    % general displacelemnt domain % 
    nMinV = -30; % (x 100) -250; % these values are in mm * 
    nMaxV = 0; % (x 100) these values are in mm
    
    % control displacement domain position
    conrolPointPos = 16;
    % control displacelemnt domain % 
    contolMinV = -30; % ( 30 x 100)  % -250; % these values are in mm
    contolMaxV = 0; % (0 x 100) these values are in mm
    
    % spacial displacement postion
    spacialDomain =  false;
    displacementPos = [4]; % u(3)=Sol(5)= 0 
    displacementMinV = 0;
    displacementMaxV = 0;
    
    expVersion = "expFull";    
    % Cost Function
    nCostFun = "mulAll"; %% V2plain  % mulAll    
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

