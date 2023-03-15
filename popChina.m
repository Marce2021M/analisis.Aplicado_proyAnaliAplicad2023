function [fx] = popChina(k,r)

global dataYear dataPop n

vecto = dataYear - 1950*ones(n,1); %ajustar los años
fx = k ./ ( 1 + exp(-r*(vecto)) .* ((k/dataPop(1)) - 1) ); % calcula P(t)
end