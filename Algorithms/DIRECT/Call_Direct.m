
% 1. Establish bounds for variables
%bounds = [-2 2;-2 2];
bounds = [nMin', nMax'];

% 2. Send options to Direct
%    We tell DIRECT that the globalmin = 3
%    It will stop within 0.01% of solution
options.testflag  = 1; 
options.globalmin = 0; % global minimum value
options.showits   = 1; % True 1 False 0 or anoy other number
options.tol       = erroTolerance; %0.00001; % tolarence

% 2a. NEW!
% Pass Function as part of a Matlab Structure
Problem.f = 'ObjFunc01_NoParam'; % test function

% 3. Call DIRECT
[fmin,xmin,hist] = Direct(Problem,bounds,options);

%% Save results
BestCost = hist;
pop = [];
BestSol.Cost = fmin;
BestSol.Position = xmin;

disp(['   Itr ' hist(end,1) ': Best Cost = ' num2str(fmin)]);
%{
% 4. Plot iteration statistics
plot(hist(:,2),hist(:,3))
xlabel('Fcn Evals');
ylabel('f_{min}');
title('Iteration Statistics for GP test Function');
%}

