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

function [Func, Feasible]=ObjFunc01V2(Sol,step,R,Tol_R,Tol_dir)

    global n_step Cpt
    global U Aff n_gdl F Fint 
    

    % load multiplier
    lambda=Sol(1);
    
    %{ 
    % increment of displacement (used to evalaute the constrain 1A)
    up(1)=Sol(Aff(Cpt,1)+1);
    up(2)=Sol(Aff(Cpt,2)+1);
    up(3)=Sol(Aff(Cpt,3)+1);
    if (step==1)
        up0=[0 0 0];
    else
        up0(1)=U(Aff(Cpt,1),step-1);
        up0(2)=U(Aff(Cpt,2),step-1);
        up0(3)=U(Aff(Cpt,3),step-1);
    end
    d=norm(up-up0);

    % displacement of the control point at the previous step (used to evalaute the constrain 2A)
    du=0; 
    if (step==1)
        du=100;
    else 
        for i = 1:n_gdl
            du = du + (Sol(i+1)-U(i,step-1))^2;
        end
        du=du^0.5
    end 
    %}
    
    % Function Value: norm of the unbalance vector R=lambda*F - Fint
    % (target = 0)     
    %{ 
    %OLD Defination
    Fint=GetResistingForceV2(Sol(2:n_gdl+1));
	Func = 0;
    for i = 1:n_gdl
        Func = Func +  (Fint(i) - lambda*F(i))^2;
    end
    Func = Func^0.5;
    %}

    
    %%{
    %NEW Definition START -----------------------------------------
    Fint=GetResistingForceV2(Sol(2:n_gdl+1));
	NormR = 0;
    for i = 1:n_gdl
        NormR = NormR +  (Fint(i) - lambda*F(i))^2;
    end
    NormR = NormR^0.5;

   	NormF = 0;
    for i = 1:n_gdl
        NormF = NormF + (lambda*F(i))^2;
    end
    NormF = NormF^0.5;

    Func=NormR/NormF;
    %NEW Definition END -----------------------------------------
    
    %}
    
	% Constrains (R parameter)
    %sumVinc= 0;
    %{
    if (abs(d-R)>Tol_R)
        sumVinc = sumVinc+ 1;   
    end
    
    % in order not to get the i-1 solution 
    if (du < Tol_dir)
        sumVinc = sumVinc+ 1;   
    end 

    % Total work >0 
	Work = 0;
    for i = 1:n_gdl
        Work = Work + Sol(1)*F(i)*Sol(i+1);
    end
    if (Work<0)
        sumVinc = sumVinc+ 1;   
    end
    
    if (sumVinc > 0) 
        Feasible = 0;  % non-fesible solution 
    else 
        Feasible = 1;  % fesible solution 
    end 
    %}
    Feasible = 1;
end    
