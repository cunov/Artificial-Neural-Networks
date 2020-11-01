train = readmatrix('training_set.csv');
trainInput = train(:,1:2);
trainTarget = train(:,3);
test = readmatrix('validation_set.csv');
testInput = test(:,1:2);
testTarget = test(:,3);

X = trainInput;
pVal = length(X);
t = trainTarget;
M1 = 2;
M2 = 2;
step = .02;
w1 = -.2 + .4.*rand(M1,2);
w2 = -.2 + .4.*rand(M2,M1);
w3 = -.2 + .4.*rand(1,M2);

V1 = zeros(1,M1);
V2 = zeros(1,M2);
theta1 = zeros(1,M1);
theta2 = zeros(1,M2);
theta3 = 0;

B1 = zeros(pVal,M1);
B2 = zeros(pVal,M2);
B3 = zeros(pVal,1);

converged = 0;
numIterations = 1;
C = zeros(1,10);

% calc Vs Bs and output
O = zeros(1,pVal);
sigO = zeros(1,pVal);
for iRun=1:10
    for mu=1:pVal
        for j=1:M1
            for i=1:2
                B1(mu,j) = B1(mu,j) + w1(j,i)*X(mu,i);
            end
            B1(mu,j) = B1(mu,j) - theta1(j);
            V1(mu,j) = tanh(B1(mu,j));
        end
        for k=1:M2
            for j=1:M1
                B2(mu,k) = B2(mu,k) + w2(k,j)*V1(mu,j);
            end
            B2(mu,k) = B2(mu,k) - theta2(k);
            V2(mu,k) = tanh(B2(mu,k));
        end
        for l=1:1
            for k=1:M2
                B3(mu,l) = B3(mu,l) + w3(l,k)*V2(mu,k);
            end
            B3(mu,l) = B3(mu,l) - theta3;
            O(mu) = tanh(B3(mu));
            if O(mu) >= 0
                sigO(mu) = 1;
            else
                sigO(mu) = -1;
            end
        end
    end

    % update weights and threshes
    delta3 = zeros(pVal,1);
    delta2 = zeros(pVal,M2);
    delta1 = zeros(pVal,M1);
%     for mu=1:pVal
%         for l=1:1
%             delta3(mu) = (t(mu) - O(mu)) * (1-tanh(B3(mu,l))^2);
%             for k=1:M2
%                 w3(k) = w3(k) + step * delta3(mu) * V2(mu,k);
%             end
%         end
%         for k=1:M2
%             for l=1:1
%                 delta2(mu,k) = delta3(mu) * w3(l,k) * (1-tanh(B2(mu,k))^2);
%             end
%             for j=1:M1
%                 w2(k,j) = w2(k,j) + step * delta2(mu,k) * V1(j);
%             end
%         end
%         for j=1:M1
%             for i=1:2
%                 tmp = 0;
%                 for k=1:M2
%                     delta1(mu,j) = delta1(mu,j) + delta2(mu,k) * w2(k,j) * (1-tanh(B1(mu,j))^2);
%                 end
%                 w1(j,i) = w1(j,i) + step * delta1(mu,j) * X(mu,i);
%             end
%         end
%         C(iRun) = C(iRun) + abs(sigO(mu) - t(mu));
%     end
    for mu=1:pVal
        for L=1:
    theta3 = theta3 - step * sum(delta3);
    for k=1:M2
        theta2(k) = theta2(k) - step * sum(delta2(:,k));
    end
    for j=1:M1
        theta1(j) = theta1(j) - step * sum(delta1(:,j));
    end
    C(iRun) = C(iRun)/(2*pVal);
end
plot(C)
