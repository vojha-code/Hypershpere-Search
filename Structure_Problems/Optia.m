% find the solution which;
% 1) zero of the objective function 1 under the two constrains 
%      A) the solution stays at a distant R from the last committed solution
%      B) u_step * u_step-1 > -1
%         where: u_step = displacement of the control point (Cpt) at the
%         current step; u_step-1 = displacement of the control point (Cpt) at the
%         previous step
% 2) minimise the increment of the external work


% Elastic prediction solution 
% -----------------------------------------------
SolOld=[
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
-2.746278503 % control point 
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
-2.139210342
];

Sol = [
    -0.6351
    0.0466
   -0.0027
    1.3538
    0.0004
   -0.0186
    1.8696
   -0.0463
   -0.0017
    1.3526
   -0.6281
    0.0038
    0.7775
   -0.2517
    0.0115
    1.7286
    0.2522
    0.0104
    1.7282
    0.6285
    0.0049
    0.7773
    0.0471
   -0.0067
    1.3399
   -0.0002
    0.0069
    1.8522
   -0.0473
   -0.0062
    1.3398];

Sol=Sol*step;
% -----------------------------------------------

% ObjFunc01: finds the equilibrium
[Func, Feasible]=ObjFunc01(Sol,step,R,Tol_R,Tol_dir);

if (step > 1)
    Lambda0=Lambda(step-1);
else
    Lambda0=0;
end    

% Compute the increment of the external work 
Func2=ObjFunc02(Sol,Lambda0);

% save the output information
Report(step,:)=[Func,Feasible,Func2];
