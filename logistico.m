function [fx] = logistico(vectoy)
global dataYear dataPop n

k=vectoy(1);
r=vectoy(2);

vecto = dataYear - 1950*ones(n,1); %ajustar los años
P = k ./ ( 1 + exp(-r*(vecto)) .* ((k/dataYear(1)) - 1) ); % calcula P(t)

u = P - dataPop; % create a vector of the differences
fx = u' * u; % Sum of squares of the differences between "P" and "y"

end

