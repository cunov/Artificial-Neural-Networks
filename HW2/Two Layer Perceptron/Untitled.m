X = readmatrix('validation_set.csv');
t = X(:,3);
X = X(:,1:2);
pVal = length(X);
C=0;
for mu=1:pVal
    B{1}(:,mu) = wGood{1} * X(mu,:)' - thetaGood{1};
    V{1}(:,mu) = tanh(B{1}(:,mu));
    for L=2:3
        B{L}(:,mu) = wGood{L} * V{L-1}(:,mu) - thetaGood{L};
        V{L}(:,mu) = tanh(B{L}(:,mu));
    end
    if V{3}(:,mu) >= 0
        sigO(:,mu) = 1;
    else
        sigO(:,mu) = -1;
    end
    C = C + abs(sigO(:,mu) - t(mu));
end
C = C/(2*pVal);