function f = ObjSOP1_FixLoad(x,load,step,R,Tol_R,Tol_dir)
    
    % ObjFunc Trail 1 (No constraint -  [-20,+20] 10 steps
    %%{ 
    
     Sol = [Load, x];
    [Func, Feasible]=ObjFunc01(Sol,step,R,Tol_R,Tol_dir);
    f = Func; %returning  the solution 
    %}
    
end