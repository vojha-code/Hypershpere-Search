function f = ObjSOP1_Org(x,step,R,Tol_R,Tol_dir)

    % Optimize x as it is
    [Func, Feasible]=ObjFunc01(x,step,R,Tol_R,Tol_dir);
    f = Func; %returning  the solution 
    %}
    
end