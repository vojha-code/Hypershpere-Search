function f = ObjSOP1_M100All(x,step,R,Tol_R,Tol_dir)
    % Modify all varaibles values
    x = x.*100; % multiply all varaible with 100
    
    [Func, Feasible]=ObjFunc01(x,step,R,Tol_R,Tol_dir);
    f = Func; %returning  the solution     
end