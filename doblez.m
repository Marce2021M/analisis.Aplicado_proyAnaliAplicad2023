function [ps] = doblez(B, g, Delta)
% This function computes a step-size for a given quadratic approximation of
% the objective function in the vicinity of the current point using the 
% D'Orazio-Brent method.
%
% Inputs:
%   - B: hessian matrix
%   - g: gradient vector
%   - Delta: trust-region radius
%
% Outputs:
%   - ps: step-size vector
%
%% Initialize the Newton direction and Cauchy direction
pN = -(B\g);
pC = -((g' * g) / (g' * B * g)) * g;

%% If Newton direction is within the trust-region radius, return it
if norm(pN) <= Delta
    ps = pN;
    
%% If Cauchy direction points outside the trust-region radius, return the
% negative of the trust-region radius times the normalized gradient
elseif norm(pC) >= Delta
    ps = -Delta * (g / norm(g));
    
%% Otherwise, compute the step-size using the D'Orazio-Brent method
else
    alfa = norm(pN - pC) ^ 2;
    beta = 2 * pC' * (pN - pC);
    gamma = norm(pC) ^ 2 - Delta ^ 2;
    r = roots([alfa beta gamma]);
    ts = max(r);
    ps = pC + ts * (pN - pC);
end
end


