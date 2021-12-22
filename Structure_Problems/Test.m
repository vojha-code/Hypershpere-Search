clear all;
close all;

% define the structure
Structure;

% test function 
% this subscript provides a test of the problem. 
% The "ObjFunc" is called considering as a input the a solution (Sol) assessed used a FEM model for a value of load factor equal to 1.0
% the test provides a feqasible solution with 0.9454 of the objective function 
% =true 
Sol=[
1
-0.076584476
-0.002704854
-2.139210342
-2.08167E-17
0.020710683
-2.95663387
0.076584476
-0.002704854
-2.139210342
1.000000072
7.35159E-16
-1.234846997
0.40000003
1.73673E-15
-0.40000003
1.74954E-15
-2.746278503
-1.000000072
7.28877E-16
-1.234846997
-0.076584476
0.002704854
-2.139210342
-2.15106E-16
-0.020710683
-2.95663387
0.076584476
0.002704854
-2.139210342];

deSol = load('exp_1_de_100K_1010_pCRp9_BestSol.mat')
Sol_new = deSol.BestSol.Position';
     
Ucp = -2.746278503;   % displacement control point 
step=1;         
% ObjFunc
[Func, Feasible]=ObjFunc(Sol_new,step,0)

% END TEST 
m=100;     % amplification factor 
DrawDeformedShape(U,m)

disp('print',Func)
%% Test 
%% Lower and Upper Bound
u = [-2; -2]; % u: column vector of lower bounds
u = repelem(-3,30,1);

v = [2; 2];  % v: column vector of upper bounds 
v = repelem(3,30,1);

%% Gloabal Minimum Value
%%-----------------------
fglob = 0.945385298520457; % global minimum of fcn
%%-----------------------

%% Global Solution
Sol=[
1
-0.076584476
-0.002704854
-2.139210342
-2.08167E-17
0.020710683
-2.95663387
0.076584476
-0.002704854
-2.139210342
1.000000072
7.35159E-16
-1.234846997
0.40000003
1.73673E-15
-0.40000003
1.74954E-15
-2.746278503
-1.000000072
7.28877E-16
-1.234846997
-0.076584476
0.002704854
-2.139210342
-2.15106E-16
-0.020710683
-2.95663387
0.076584476
0.002704854
-2.139210342];

xglob = Sol; % column vector of global minimum
%xglob = [0.; -1.]; % column vector of global minimum

%%Numbe of gloabal solution
nglob = 1; % number of global minimizers in the box [u,v]

%val = bridge(Sol)
%DrawDeformedShape(U,m)




