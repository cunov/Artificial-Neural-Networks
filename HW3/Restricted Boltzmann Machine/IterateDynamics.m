function [v0, vK, bH0, bHK] = IterateDynamics(pattern,W,biasV,biasH,K)
    numHiddenNeurons = size(W,1);
    numVisibleNeurons = size(W,2);
    v = pattern;
    v=[0 -1 0 0 -1  0 0 -1 0 ]';
    v0 = v;
    bH = W * v - biasH';
    bH0 = bH;
    h = [];
    for i = 1:numHiddenNeurons
        if rand < GetProbabilityFromB(bH(i))
            h(i) = 1;
        else
            h(i) = -1;
        end
    end
    h = h';
    vPrint=[];
    for t = 1:K
        bV = (h' * W - biasV)';
        vPrint = [vPrint v];
        for j = 1:numVisibleNeurons
            if rand < GetProbabilityFromB(bV(j))
                v(j) = 1;
            else
                v(j) = -1;
            end
        end
        bH = W * v - biasH';
        for i = 1:numHiddenNeurons
            if rand < GetProbabilityFromB(bH(i))
                h(i) = 1;
            else
                h(i) = -1;
            end
        end
    end
    bHK = bH;
    vK = v;
end

