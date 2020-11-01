function W = InitializeWeights(numVisible,numHidden)
    W = zeros(numVisible,numHidden);
    for i=1:numVisible
        for j=1:numHidden
            W(i,j) = -1 + 2*rand;
        end
    end
    W = W';
end

