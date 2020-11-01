clear all
train = readmatrix('training_set.csv');
trainInput = train(:,1:2);
trainTarget = train(:,3);
test = readmatrix('validation_set.csv');
testInput = test(:,1:2);
testTarget = test(:,3);

X = trainInput;
pVal = length(X);
t = trainTarget;
Cmin = 100000;
for M1=1:10
    for M2=1:10
        % M1 = 5;
        % M2 = 2;
        step = .002;
        w{1} = -.2 + .4.*rand(M1,2);
        w{2} = -.2 + .4.*rand(M2,M1);
        w{3} = -.2 + .4.*rand(1,M2);
        theta{1} = -.02 + .04.*rand(M1,1);
        theta{2} = -.02 + .04.*rand(M2,1);
        theta{3} = 0;

        % w{1} = ones(M1,2);
        % w{2} = ones(M2,M1);
        % w{3} = ones(1,M2);
        % theta{1} = zeros(M1,1);
        % theta{2} = zeros(M2,1);
        % theta{3} = 0;

        B{1} = zeros(M1,pVal);
        B{2} = zeros(M2,pVal);
        B{3} = zeros(1,pVal);
        V{1} = zeros(M1,pVal);
        V{2} = zeros(M2,pVal);
        V{3} = zeros(1,pVal);
        sigO = zeros(1,pVal);
        err{1} = zeros(M1,pVal);
        err{2} = zeros(M2,pVal);
        err{3} = zeros(1,pVal);

        converged = 0;
        numIterations = 1;
        C = zeros(1,10);
        deltaW{1} = zeros(M1,2,pVal);
        deltaW{2} = zeros(M2,M1,pVal);
        deltaW{3} = zeros(1,M2,pVal);
        for iRun=1:10
            for mu=1:pVal
                % calc Bs, Vs, and final output sigO
                B{1}(:,mu) = w{1} * X(mu,:)';
                V{1}(:,mu) = tanh(B{1}(:,mu) - theta{1});
                for L=2:3
                    B{L}(:,mu) = w{L} * V{L-1}(:,mu);
                    V{L}(:,mu) = tanh(B{L}(:,mu) - theta{L});
                end
                if V{3}(:,mu) >= 0
                    sigO(:,mu) = 1;
                else
                    sigO(:,mu) = -1;
                end
                % calc errors and deltaWs
                err{3}(:,mu) = (t(mu)-V{3}(:,mu)) * (1-tanh(B{3}(:,mu))^2);
                deltaW{3}(:,:,mu) = err{3}(:,mu) * V{2}(:,mu)';
                err{2}(:,mu) = w{3}' * err{3}(:,mu) .* (1-tanh(B{2}(:,mu)).^2);
                deltaW{2}(:,:,mu) = err{2}(:,mu) * V{1}(:,mu)';
                err{1}(:,mu) = w{2}' * err{2}(:,mu) .* (1-tanh(B{1}(:,mu)).^2);
                deltaW{1}(:,:,mu) = err{1}(:,mu) * X(mu,:);
                C(iRun) = C(iRun) + abs(sigO(:,mu) - t(mu));
            end
            for L=1:3
                w{L} = w{L} + step .* sum(deltaW{L},3);
                theta{L} = theta{L} - step .* sum(err{L},2);
            end
            C(iRun) = C(iRun) / (2*pVal);
        end
        if C(end) < Cmin
            bestMs = [M1 M2];
            Cmin = C(end);
            bestW1 = w{1};
            bestW2 = w{2};
            bestW3 = w{3};
            bestT1 = theta{1};
            bestT2 = theta{2};
            bestT3 = theta{3};
            bestC = C;
        end
    end
end
bestMs