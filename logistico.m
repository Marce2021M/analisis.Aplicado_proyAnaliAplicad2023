function [fx] = logistico(vectoy)

global dataYear dataPop n

P= popChina(vectoy(1),vectoy(2)); %calculamos P(t)

u = P - dataPop; % create a vector of the differences
fx = u' * u; % Sum of squares of the differences between "P" and "y"

end

