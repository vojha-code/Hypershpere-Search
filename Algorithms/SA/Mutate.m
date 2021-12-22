%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA106
% Project Title: Real-Coded Simulated Annealing in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Real-Coded Simulated Annealing (SA) in MATLAB (URL: https://yarpiz.com/421/ypea106-real-coded-simulated-annealing), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function y = Mutate(x, mu, sigma, VarMin, VarMax)

    A = (rand(size(x)) <= mu);
    J = find(A == 1);

    y = x;
    y(J) = x(J)+sigma*randn(size(J));

    % Clipping
    y = max(y, VarMin);
    y = min(y, VarMax);
    
end