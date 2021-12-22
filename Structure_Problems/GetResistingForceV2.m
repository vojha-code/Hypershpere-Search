% evaluate the internal forced of the structure corresponding to the
% displacement U
function [Fint]=GetResistingForceV2(U)

    global Aff n_gdl n_elem
    global elements
    global nodes
    
    % F_int : internal forces vector  
    % U     : displacement vector   

    Fint(n_gdl) = 0;
    
	for (i = 1:n_elem)

        % evalaute the elongation and orientation of the strut  
       	Idxn1=find(nodes(:,1)==elements(i,1));
    	Idxn2=find(nodes(:,1)==elements(i,2));
        
        [L, dir]=UpdateStateV2(Idxn1,Idxn2,U);
        
        % evaluate the reactive force of the element  
        f_trial=GetForce(i, L, elements(i,4));
        
        % assemble the global vector 
        for (j = 1:3)
            g1=Aff(Idxn1,j);
            g2=Aff(Idxn2,j);
            
            if (g2 > 0)
                Fint(g2)=Fint(g2)+f_trial*dir(j);
            end
            if (g1 > 0)
                Fint(g1)=Fint(g1)-f_trial*dir(j);
            end
        end
    end        
end
        
