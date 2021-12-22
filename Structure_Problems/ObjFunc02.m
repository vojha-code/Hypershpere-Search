% Func Value  = Increment of the external work
% Func Target = minimum vaue among all the equilibrated solutions 
% Domain      = [-ing \ inf]
%
% INPUT PARAMETERS 
% Sol     : trial solution 
%         Sol(1)          = load multiplier
%         Sol(2:m_gdl-1)  = unknown displacements 
% lambda0 :  load multiplier at the previous step   
function [Func]=ObjFunc02(Sol,lambda0)

    global n_gdl F  
    
    % load multiplier
    lambda=Sol(1);

    % compute the increment of external work
	Func = 0;
    for i = 1:n_gdl
        Func = Func + 0.5*(lambda + lambda0)*F(i)*Sol(i+1);
    end
end    
