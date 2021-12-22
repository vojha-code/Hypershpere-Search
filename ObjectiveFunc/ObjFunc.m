function [Func, Feasible]=ObjFunc(Sol,step,dO)

    global Ucp n_step Ipt Ipt_gdl
    global U Aff n_gdl F Fint 
    
    % Sol : trial solution 
    %       Sol(1)          = load multiplier
    %       Sol(2:m_gdl-1)  = unknown displacements 
    % step : current step of the analysis  
    % dO   : committed absolute displacement of the control point (used to evaluate the constrain)

    % Deformed configuration (vector U containing the values of the degrees of freedom)
    U(Ipt_gdl) = Ucp/n_step*step;   % current displacement of the control point     
    for i = 1:n_gdl
        if (i < Ipt_gdl)
            U(i) = Sol(i + 1);
        elseif (i > Ipt_gdl)
            U(i) = Sol(i);
        end
    end
    
    % load multiplier
    lambda=Sol(1);
    
    % d: absolute displacement of the control point (used to evalaute the constrains)
	
    up(1)=U(Aff(Ipt,1));
    up(2)=U(Aff(Ipt,2));
    up(3)=U(Aff(Ipt,3));
    d=norm(up); 
    
    % Function Value: norm of the unbalance vector R=lambda*F - Fint
    % (target = 0)     
    Fint=GetResistingForce(U);
	Func = 0;
    for i = 1:n_gdl
        Func = Func +  (Fint(i) - lambda*F(i))^2;
    end
    Func = Func^0.5;

	% Constrain   
    dmax=2.5*abs(Ucp)/n_step;
    if (d<dmax)
        Feasible = 1;  % fesible solution 
    else 
        Feasible = 0;  % non-fesible solution 
    end 
    
    
    
    
