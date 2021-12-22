clc;
clear;
close all;

warning('off')
%---------------------------------------------------
% define the structure
%---------------------------------------------------
Benchmark1;                            %30 dof not from literature
%Eight_Member_Symmetric_Shallow_Truss;  %3 dof from literature 
%Sixteen_member_shallow;                %15 dof from literature
%Arch                                    % 104 dof from literature       

%response vector  
%U(n_gdl,nStep)=0;

%U = load('C:\Users\yl918888\Dropbox\00Research\00Research_Coding\Civil_Eng_Project\civil_solution_2d_start\U_2dstart.mat');
U = load('C:\Users\yl918888\Dropbox\00Research\00Research_Coding\Civil_Eng_Project\civil_solutions_bridge\U_bridge.mat')
U = U.U;
%%
for step=1:nStep

    % find the solution which;
    % 1) zero of the objective function 1 under the two constrains 
    %      A) stays at a distant R from the last committed solution
    %      B) u_step * u_step-1 > -1
    %         where: u_step = displacement of the control point (Cpt) at the
    %         current step; u_step-1 = displacement of the control point (Cpt) at the
    %         previous step
    % 2) minimise the increment of the external work
    %Optia;

    % save the state 
    %U(1:n_gdl,step)=Sol(2:n_gdl+1);
    %Lambda(step)=Sol(1);
    
    % plot the deformed shape  
    m=100;     % amplification factor 
    close all;
    DrawDeformedShape(U(:,step),m)
end


