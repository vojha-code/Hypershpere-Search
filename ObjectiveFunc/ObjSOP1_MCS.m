function f = ObjSOP1_MCS(x)  
    size(x)
    %Sol = ones(size(x)).*100;
    %Sol(1) = 1;    
    Sol = x.*100;
    f = ObjFunc01_MCS(Sol);
end