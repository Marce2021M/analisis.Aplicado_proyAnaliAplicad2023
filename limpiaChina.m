M = readtable("population-and-demography.csv");
cond = M.CountryName == "China"; 
china = M(cond,:);
china = china(:,1:3);

save('chinalimpio', 'china');