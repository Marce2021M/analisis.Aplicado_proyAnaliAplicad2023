function [fx,Po] = logistico(K,r,t,y)
% Modelo Logístico


n = 72;
vecto = t - 1950*ones(n,1);
P = K ./ ( 1 + exp(-r*(vecto)) .* ((K/y(1)) - 1) ); % P(t)

u = P' - y; %creamos un vector de las restas
fx = u' * u; %Suma de cuadrados de la diferencia entre "P" y "y"

% FIN
Po = P';
end

