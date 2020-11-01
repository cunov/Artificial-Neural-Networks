function vector = GeneratePattern(rows,cols)
% Generates a matrix of 1s and -1s, each with probability 1/2, of size
% rows x cols
    vector = randi([0 1],rows,cols);
    vector(vector==0) = -1;
end

