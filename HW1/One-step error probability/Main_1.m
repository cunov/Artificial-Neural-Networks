N = 120;
probs = zeros(1,6);
c = 0;
numTrials = 10^5;
for p = [12,24,48,70,100,120]
    matches = zeros(1,10^5);
    X = GeneratePattern(p,N);
    W = (X'*X - p*eye(N))/N;
    for i=1:numTrials
        iRand = randi(p,1);
        test_pattern = X(iRand,:);
        iRand2 = randi(N,1);
        matches(i) = OneStepError(test_pattern,W,N,iRand2);
    end
    c = c + 1;
    probs(c) = 1 - sum(matches)/numTrials;
end
probs