% Modelo Logístico% 

global china dataYear dataPop n

china = load('chinalimpio.mat');
dataYear = table2array(china.china(:, 2));
dataPop = table2array(china.china(:, 3));

% Perform element-wise division on the third column of the 'china' table
dataPop = dataPop / 1e+9;

n = length(dataYear); % get the length of t vector


x=[1 1]';

[xf, j] = desnewton('logistico', x);