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

xf

[x,k, vg] = regioncon('logistico',x);

x


% REGION DE CONFIANZA
% Create a figure window
figure;
vecto = dataYear - 1950*ones(n,1); %ajustar los años
% Plot the function as a solid line
plot(vecto, popChina(x(1),x(2)), 'LineWidth', 2);

hold on; % Keep the plot window open to add the scatterplot

% Plot the scatterplot of random points as circles
scatter(vecto, dataPop, 'o', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'black');

% DESCENSO DE NEWTON (CHECAR EL NAN)
% Create a figure window
figure;
vecto = dataYear - 1950*ones(n,1); %ajustar los años
% Plot the function as a solid line
plot(vecto, popChina(xf(1),xf(2)), 'LineWidth', 2);

hold on; % Keep the plot window open to add the scatterplot

% Plot the scatterplot of random points as circles
scatter(vecto, dataPop, 'o', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'black');
