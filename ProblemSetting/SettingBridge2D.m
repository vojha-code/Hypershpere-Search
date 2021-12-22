%---------------------------------------------------
% define the structure
%---------------------------------------------------
if (nProblem == "Bridge2D")
    Bridge2D;      %  load +   30 dof not from literature - bridge
    %[1, 10] and [-100, +100]
    erroTolerance = 10^-5;
    
    nVariables = n_gdl+1;%  % 1 load + n_gdl DoF

    % load multiplier domain (0 900)
    loadLow = 0; % (x 100) 
    loadHigh = 10; % (x 100) 
    
    % general displacelemnt domain % 
    nMinV = -100; % (x 100) -250; % these values are in mm * 
    nMaxV = 100; % (x 100) these values are in mm
    
    % control displacement domain position
    conrolPointPos = 16;
    % control displacelemnt domain % 
    contolMinV = nMinV; % ( 30 x 100)  % -250; % these values are in mm
    contolMaxV = nMaxV; % (0 x 100) these values are in mm
    
    % spacial displacement postion
    spacialDomain =  false;
    displacementPos = [4]; % u(3)=Sol(5)= 0 
    displacementMinV = 0;
    displacementMaxV = 0;
    
    expVersion = "expTest";
    % Cost Function
    nCostFun = "mulNoneV2"; %% V2plain  % mulAll
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

