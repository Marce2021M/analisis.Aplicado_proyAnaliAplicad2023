function [x, k, vg] = regioncon(fname, x0)
% This function minimizes a given function 'fname' using the region contraction method.
% It starts from the initial guess 'x0' and returns the solution 'x', the number of iterations 'k', and the norm of the gradients 'vg' at each iteration.

%% PARAMS
tol = 1.e-04;  % tolerance for the norm of the gradient
Dmin = 1.e-05; % minimum step size
Dmax = 10;     % maximum step size
eta = 1/4;     % contraction factor
kmax = 50;     % maximum number of iterations


%% Initial vars
% Calculate the gradient of the function at the initial guess x,
% and initialize the norm of the gradient and the number of iterations to zero.

n = length(x0);               % dimension of the input vector
gx0 = gradiente(fname, x0);   % gradient of the function at the initial guess
vg0 = norm(gx0);              % norm of the gradient at the initial guess
k = 0;                        % iteration counter
D = 1.0;                      % step size (Trust region (delta))

%% Algorithm 
% This is the main loop of the algorithm that continues until either the 
% norm of the gradient is less than the tolerance "tol" or the maximum number 
% of iterations "kmax" has been reached.

while ( norm(gx0) > tol && k < kmax)

    Bx0 = hessiana(fname, x0); % hessian of the function at the current point
    
    %% Regularization of the hessian

    % Calculate the eigenvalues of the Hessian matrix. 
    % We need to make sure that all eigenvalues are positive, 
    % otherwise we adjust the Hessian matrix to make all eigenvalues positive.

    vBx0 = eig(Bx0);           % eigenvalues of the hessian
    vminBx0 = min(vBx0);       % minimum eigenvalue of the hessian
    
    % Ensure that the hessian is positive definite by adding a small positive value to its diagonal elements.
    if (vminBx0 <= 0)
        Bx0 = Bx0 + (abs(vminBx0) + 0.5) * eye(n);
    end

    %% Optimize and compute new values using 'doblez method'
    
    px0 = doblez(Bx0, gx0, D);  % compute the search direction using the 'doblez' method

    fx0 = feval(fname, x0);     % evaluate the function at the current point
    fx1 = feval(fname, x0 + px0); % evaluate the function at the new point
    mp = (1/2) * px0' * Bx0 * px0 + gx0' * px0 + fx0; % estimate of the function value at the new point
    rho = (fx0 - fx1) / (fx0 - mp);  % compute the contraction factor
    
    %% update the step size based on the contraction factor

    % If the reduction ratio is less than the reduction factor eta, 
    % reduce the step size D by the reduction factor.

    if(rho < eta)
        D = max(Dmin, (1/4) * norm(px0) );
    else
        
    % Otherwise, if the reduction ratio is greater than (1-eta), 
    % and the step size D is equal to the norm of the search direction p,
    % increase the step size D by the increase factor.

        if ( rho > (1-eta) && D == norm(px0))
            D = min(Dmax, 2 * D);
        end
    end
    %---------------------------------------
    %% update the current point If the function value improves (HYPOTESIS TEST)
    if (rho > eta)
        x0 = x0 + px0;
        gx0 = gradiente(fname, x0);
        vg0 = [vg0; norm(gx0)];
    end
    %---------------------------------------
    k = k + 1; % increase the iteration counter
end

%% output the final solution, iteration count, and norm of gradients

x = x0;
%k
vg = vg0;

end


