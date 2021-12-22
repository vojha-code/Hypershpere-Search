clear all;
close all;

%%
%---------------------------------------------------
% define the structure
%---------------------------------------------------
%%%Benchmark1
%Eight_Member_Symmetric_Shallow_Truss;   % 3 dof from literature 
%Sixteen_member_shallow;                 %15 dof from literature
%Arch;                                 % 104 dof from literature       
%Dome; % [1, 100] and [-100, +100]
Bridge2D; %[1, 10] and [-100, +100]
%%
%response vector  
U(n_gdl,nStep)=0;
Utest(n_gdl)=0;

%stidffness matrix
Kg(n_gdl,n_gdl)=0;
for (e = 1:n_elem)

    % evalaute the elongation and orientation of the strut    
    n1=find(nodes(:,1)==elements(e,1));
    n2=find(nodes(:,1)==elements(e,2)); 
    [L, dir]=UpdateStateV2(n1,n2,Utest);

    % evaluate the reactive force of the element  
    k=[elements(e,3) -elements(e,3);-elements(e,3) elements(e,3)];
    
    for (i =1:2)
        for (j =1:2)
            for (p =1:3)
                for (q =1:3)

                    n1=find(nodes(:,1)==elements(e,i));
                    n2=find(nodes(:,1)==elements(e,j));  
    
                    g1=Aff(n1,p);
                    g2=Aff(n2,q);
                    
                    if ((g1 > 0) && (g2 > 0))
                        Kg(g1,g2)=Kg(g1,g2)+k(i,j)*dir(p)*dir(q);
                    end
                end
            end
        end
    end  
end

lb=1; % for dome and bridge

%lb = 0.01;% for arch

%Utest=lb*Kg^(-1)*F';

%m=100;           % amplification factor    
%%
BestSol.Cost
lambda =  BestSol.Position(1);
displacement =  BestSol.Position(2:size(BestSol.Position,2));
Utest=displacement;

%%
figure(1);
%Dome;
%Arch;
%Bridge2D;
DrawStructureDome(elements,nodes);
%m=1;           % amplification factor 
m=100;           % amplification factor 
hold on; 
DrawDeformedShapeDome(Utest,m);
hold off; 
%TestSol =  unifrnd(VarMin, VarMax, VarSize); 

%%

[Func, Feasible]=ObjFunc01V2([lb; Utest],1,R,Tol_R,Tol_dir)

%{    
for step=1:nStep

    % find the solution which;
    % 1) zero of the objective function 1 under the two constrains 
    %      A) stays at a distant R from the last committed solution
    %      B) u_step * u_step-1 > -1
    %         where: u_step = displacement of the control point (Cpt) at the
    %         current step; u_step-1 = displacement of the control point (Cpt) at the
    %         previous step
    % 2) minimise the increment of the external work
    Optia;

    % save the state 
    U(1:n_gdl,step)=sol(step,2:n_gdl+1);
    %Lambda(step)=Sol(1);
    
    % plot the deformed shape  
    m=100;     % amplification factor 
    figure(1);
    DrawDeformedShape(U(:,step),m);
    hold on;
end
%}

