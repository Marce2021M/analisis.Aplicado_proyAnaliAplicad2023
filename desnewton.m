function [xf, j] = desnewton(fname, x)
% Newton's direction descent method for finding a local minimum.

%% PARAMS
tolerance = 1e-05; % tolerance for the norm of the gradient
maxIterations = 15;
c1 = 0.1;           % Constante utilizada para la búsqueda de línea.
maxLineSearchIterations = 10;

%% Initial vars

gradient = gradiente(fname,x); % calculate the gradient of the function at x
functionValue = feval(fname,x); % calculate the value of the function at x
j = 0; % initialize iteration counter
n = length(x);             % dimension of the input vector

%% Algorithm 

while (norm(gradient) > tolerance && j < maxIterations)

    hessian = hessiana(fname, x); % calculate the Hessian matrix of the function at x
    
    %% Regularization of the hessian

    % Calculate the eigenvalues of the Hessian matrix. 
    % We need to make sure that all eigenvalues are positive, 
    % otherwise we adjust the Hessian matrix to make all eigenvalues positive.

    vhessian = eig(hessian);           % eigenvalues of the hessian
    vminHessian = min(vhessian);       % minimum eigenvalue of the hessian
    
    % Ensure that the hessian is positive definite by adding a small positive value to its diagonal elements.
    if (vminHessian <= 0)
        hessian = hessian + (abs(vminHessian) + 0.5) * eye(n);
    end

    
    %% Solve the linear system H * p = -g for the Newton direction p (direction)
    direction = -(hessian\gradient); 

    %% line search (step size)
    alpha = 1.0;
    xNew = x + alpha * direction;
    functionValueNew = feval(fname, xNew);
    k = 0; % initialize line search iteration counter

    % Backtracking line search to find a suitable step size alpha
    while (functionValueNew > functionValue + alpha * c1 * gradient' * direction ...
        && k < maxLineSearchIterations)
        alpha = alpha/2;
        xNew = x + alpha * direction;
        functionValueNew = feval(fname, xNew);
        k = k + 1;
    end

    % If the maximum line search iterations is reached, then set alpha to 1.0
    if(k == maxLineSearchIterations)
        alpha = 1.0;
    end

    %% update x and the function value
    x = x + alpha * direction;
    functionValue = feval(fname, x);
    gradient = gradiente(fname, x); % calculate the gradient of the function at x
    j = j + 1; % increment iteration counter

    %% print iteration information
    fprintf('%2.0f %2.8f \n ', j , norm(gradient)); 
end
xf = x; % return the optimal point
end
