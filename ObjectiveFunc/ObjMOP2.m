%
% Copyright (c) 2016, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA126
% Project Title: Non-dominated Sorting Genetic Algorithm III (NSGA-III)
% Publisher: Yarpiz (www.yarpiz.com)
%
% Implemented by: Mostapha Kalami Heris, PhD (member of Yarpiz Team)
%
% Cite as:
% Mostapha Kalami Heris, NSGA-III: Non-dominated Sorting Genetic Algorithm, the Third Version — MATLAB Implementation (URL: https://yarpiz.com/456/ypea126-nsga3), Yarpiz, 2016.
%
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
% Base Reference Paper:
% K. Deb and H. Jain, "An Evolutionary Many-Objective Optimization Algorithm
% Using Reference-Point-Based Nondominated Sorting Approach, Part I: Solving
% Problems With Box Constraints, "
% in IEEE Transactions on Evolutionary Computation,
% vol. 18, no. 4, pp. 577-601, Aug. 2014.
%
% Reference Paper URL: http://doi.org/10.1109/TEVC.2013.2281535
%

function z = ObjMOP2(x,step,R,Tol_R,Tol_dir,domainList)
%{
    n = numel(x);
    z1 = 1-exp(-sum((x-1/sqrt(n)).^2));
    z2 = 1-exp(-sum((x+1/sqrt(n)).^2));
    z = [z1 z2]';
%}
    % ObjFunc
    %[Func, Feasible] = ObjFunc01(x,step,R,Tol_R,Tol_dir);
    [z1, z3] = ObjFunc01(x,step,R,Tol_R,Tol_dir);
    
    
    controlPoint =  x(4);
    z2 = 0;
    for i = 1:length(domainList)
        if (controlPoint > domainList(i,1) & controlPoint  < domainList(i,2))
            z2 = i;
        break
        end
    end
    z = [z1  0];
end


