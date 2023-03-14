function [xf, j] = desnewton(fname, x)
% Método de descenso por dirección de Newton para aproximar un mínimo
% local. 
tol = 1e-05; % tolerancia a la norma del gradiente
jmax = 15;
c1 = 0.1;
kmax = 10;

g = gradiente(fname,x); fx = feval(fname,x);
j = 0;
while (norm(g) > tol && j < jmax)
    H = hessiana(fname, x);
    % Sistema lineal H*p = -g
    p = -(H\g); % Dirección de Newton
        % dirección de descenso
    % búsqueda de línea
    alfa = 1.0;
    xp = x + alfa*p;
    fxp = feval(fname,xp);
    k = 0;
    while (fxp > fx + alfa*(c1*g'*p) && k < kmax)
        alfa = alfa/2;
        xp = x + alfa*p;
        fxp = feval(fname,xp);
        k = k+1;
    end
    %-------------------
    if(k == kmax)
        alfa = 1.0;
    end
    x = x + alfa*p; fx = feval(fname,x);
    g = gradiente(fname,x);
    j = j+1;
    fprintf('%2.0f %2.8f \n ', j , norm(g));
end
xf =x;
end