function f = ObjSOP1V2(x,step,R,Tol_R,Tol_dir)

    [Func, Feasible]=ObjFunc01V2(x,step,R,Tol_R,Tol_dir);
    f = Func; %returning  the solution 

end