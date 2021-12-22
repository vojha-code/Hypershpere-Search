function f = ObjSOP1_M100DispV2(x,step,R,Tol_R,Tol_dir)
       
    % modify only displacement
    Sol = x(2:end).*100;
    Sol = [x(1) Sol]; % keep load as it is.    
    
    [Func, Feasible]=ObjFunc01V2(Sol,step,R,Tol_R,Tol_dir);
    f = Func; %returning  the solution 
    
end