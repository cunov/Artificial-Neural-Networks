function PB = EstimateBoltzmannDistn(W,biasV,biasH,dat)
    PB = zeros(1,14);
    numHiddenNeurons = size(W,1);
    numVisibleNeurons = size(W,2);
    for T=1:20000
        randPattern = randi([0 1],9,1);
        randPattern(randPattern==0) = -1;
        [v0, vK, bH0, bHK] = IterateDynamics(randPattern,W,biasV,biasH,12);

        for mu = 1:14
            if isequal(dat(mu,:),vK')
                PB(mu) = PB(mu) + 1;
            end
        end
    end
    PB = PB / 20000;
end

