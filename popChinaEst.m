function [fx] = popChinaEst(k,r)

global dataPop n

vecto = linspace(1950,2100,151) - 1950*ones(n,1); %ajustar los años
fx = k ./ ( 1 + exp(-r*(vecto)) .* ((k/dataPop(1)) - 1) ); % calcula P(t)
end