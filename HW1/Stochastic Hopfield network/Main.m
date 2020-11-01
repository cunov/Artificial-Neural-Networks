N = 200;
p = 7;
% p = 45;
T = 2*10^5;
beta = 2;

avg_ms = zeros(1,100);

for i = 1:100
    X = GeneratePattern(p,N);
    W = (X'*X - p*eye(N))/N; % Wii = 0

    pattern_original = X(1,:);
    pattern = pattern_original;
    m = zeros(T,1);
    for t = 1:T
        pattern = aSynchronousStochasticUpdate(pattern,W,N,beta);
        m(t) = Calculate_m(pattern,pattern_original,N);
    end
    avg_ms(i) = mean(m);
end
disp('< m1(T) >')
disp(mean(avg_ms))