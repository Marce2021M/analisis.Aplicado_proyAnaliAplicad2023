function [ xf, j ] = desmax(fname, x)
% 

tol = 1e-05;  % tolerancia a la norma del gradiente
jmax = 100;   % número máximo de iteraciones
c1 = 0.0001;     % parámetro para np dar pasos grandes
kmax = 100;     % número  máximo de pasos hacia atrás

g = gradiente(fname,x);  fx = feval(fname,x);
j = 0;
while (norm(g) > tol && j < jmax )
    p = -g;      % dirección de descenso
    % búsqueda de línea
    alfa = 1.0;
    xp = x + alfa*p;
    fxp = feval(fname,xp);
    k = 0;
    while( fxp > fx + alfa*( c1*g'*p ) && k < kmax)
        alfa = alfa/2;
        xp = x + alfa*p;
        fxp = feval(fname,xp);  
        k = k+1;
    end
    %------------------------------------
    x = x +alfa*p;  fx = feval(fname,x);
    g = gradiente(fname,x);
    j = j+1;
end

xf = x;

end

