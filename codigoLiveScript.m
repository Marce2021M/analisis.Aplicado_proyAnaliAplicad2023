% Modelo Logístico% 

global china dataYear dataPop n  %asignamos variables globales

china = load('chinalimpio.mat');  %cargamos datos

%definimos variables a utilizar
dataYear = table2array(china.china(:, 2));  
dataPop = table2array(china.china(:, 3));
dataPop = dataPop / 1e+9;
n = length(dataYear); % get the length of t vector

% Corremos métodos numéricos en un punto en específico

% Método de región de confianza
x=[2 2]';
[x,k, vg] = regioncon('logistico',x);
x

k

% Método de descenso de Newton
% xN = [1.66915416161604 0.0365611162817698];
xN = [2,2];
[xf, j] = desnewton('logistico', xN);

xf

j

% CREAMOS PLOTS


% REGION DE CONFIANZA

figure; % Create a figure window

%ajustar los años
vecto = dataYear - 1950*ones(n,1); 
y = (1950:10:2100)';
vectow = (1950:2110)';

% Plot the function as a solid line
plot(vectow, popChinaEst(x(1),x(2)) , 'm', 'LineWidth', 2);

hold on; % Keep the plot window open to add the scatterplot

% Plot the scatterplot of points as circles
scatter(dataYear, dataPop, 'o', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'black');

popEstimates = popChinaEst(x(1),x(2));
scatter((2020:10:2110)',popEstimates(71:10:end) ,'o', 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'black');


fut=popEstimates(71:10:end);
% Add text labels for the data location of the points beyond 2021
for i = (2020:20:2100)'
    j=(i-2010)/10;
    text(i, fut(j), "("+num2str(i)+" , "+num2str(fut(j))+")", 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 12);
end

for i = (2030:20:2100)'
    j=(i-2010)/10;
    text(i, fut(j), "("+num2str(i)+" , "+num2str(fut(j))+")", 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 12);
end

title("Región de Confianza");
xlabel('Periodo de tiempo');
ylabel('Mil millones de personas');
xticks(y);




% DESCENSO DE NEWTON (CHECAR EL NAN)
% Create a figure window
figure;

% Plot the function as a solid line
plot(vectow, popChinaEst(xf(1),xf(2)), 'm', 'LineWidth', 2);

hold on; % Keep the plot window open to add the scatterplot

% Plot the scatterplot of random points as circles
scatter(dataYear, dataPop, 'o', 'MarkerFaceColor', 'blue', 'MarkerEdgeColor', 'black');

popEstimates = popChinaEst(xf(1),xf(2));
scatter((2020:10:2110)',popEstimates(71:10:end) ,'o', 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'black');


fut=popEstimates(71:10:end);
% Add text labels for the data location of the points beyond 2021
for i = (2020:20:2100)'
    j=(i-2010)/10;
    text(i, fut(j), "("+num2str(i)+" , "+num2str(fut(j))+")", 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 12);
end

for i = (2030:20:2100)'
    j=(i-2010)/10;
    text(i, fut(j), "("+num2str(i)+" , "+num2str(fut(j))+")", 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 12);
end


title("Newton");
%legend({'Estimación población China','Datos China'},'Location','south')
xlabel('Periodo de tiempo');
ylabel('Mil millones de personas');
xticks(y);



