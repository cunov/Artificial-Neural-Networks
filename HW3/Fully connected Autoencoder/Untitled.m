foundTen = 0;
found = cell(10,1);
i=1;
while foundTen ~= 10
    digit = tTrain(i);
    if isempty(found{digit})
        found{digit} = xTrainAdj(:,i);
        foundTen = foundTen + 1;
    end
    i = i + 1;
end        
digits = found;