function [H] = hessiana(fname,x)
% Aproximación a la matriz hessiana de fname en x. 

h = 1e-05;
h2 = h * h;
n = length(x);
H = zeros(n);
fx = feval(fname,x);

for j = 1:n
    x1 = x; x1(j) = x1(j) + h;
    fx1 = feval (fname,x1);
    
    for i = 1:j
        x2 = x; x2(i) = x2(i) + h;
        x3 = x1; x3(i) = x3(i) + h; 
        % x3(j)= x3(j) + h = x1;
        fx2 = feval (fname, x2);
        fx3 = feval(fname, x3);
        H(i,j) = (fx3-fx2-fx1 + fx)/(h2);
        H(j,i) = H(i,j);
        
    end
end

