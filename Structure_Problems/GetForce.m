% Evaluate internal force of the ith element with currnet lenght (L) and orientation (dir)
function [f]=GetForce(e,L,LO)

    global elements
    
    f=elements(e,3)*(L-LO);

end
        
