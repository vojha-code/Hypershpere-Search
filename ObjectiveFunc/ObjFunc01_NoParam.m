% Func Value  = Equilibrium unbalance
% Func Target = 0
% Domain      = [0 \ inf]
%
% CONSTRAINS:
%      A) the displacement magniture of the control point should stay at a distance of R from the previous 
%      B) the product (up * up0) > -1 where up0 is the displacement of the
%      control pointat the current step and up0 the displacement of the
%      control point at the previous step.
% 
% INPUT PARAMETERS 
% Sol : trial solution 
%       Sol(1)          = load multiplier
%       Sol(2:m_gdl-1)  = unknown displacements 
% step : current step of the analysis  

function Func = ObjFunc01_NoParam(x)
    global  n_gdl F Fint;
    
    %size(x)
    % mulDisp
    Sol = x(2:end).*100;
    Sol = [x(1); Sol]; % keep load as it is.  
    
    
    
    lambda=Sol(1); 

    % Function Value: norm of the unbalance vector R=lambda*F - Fint
    % (target = 0)     
    Fint=GetResistingForce(Sol(2:n_gdl+1));
	Func = 0;
    for i = 1:n_gdl
        Func = Func +  (Fint(i) - lambda*F(i))^2;
    end
    Func = Func^0.5;

end    
