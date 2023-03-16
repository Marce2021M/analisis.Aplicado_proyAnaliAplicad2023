function [fx] = popChinaEst(k,r)

global dataPop n

vecto = (1950:2110)' - 1950*ones(161,1); %ajustar los años
fx = k ./ ( 1 + exp(-r*(vecto)) .* ((k/dataPop(1)) - 1) ); % calcula P(t)
end