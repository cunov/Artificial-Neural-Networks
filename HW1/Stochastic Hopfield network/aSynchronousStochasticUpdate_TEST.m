function new_pattern = aSynchronousStochasticUpdate_TEST(s,W,N,beta,T)
%Outputs new_pattern after asynchronously updating input
%pattern s according to weight matrix W, bit-length N, and noise parameter beta 
 
    new_pattern = zeros(1,N);
    for i = 1:T
        indices = 1:N;
        randIndices = indices(randperm(N));
  
        for j = randIndices
            b = W(j,:)*s';
            prob_b = 1/(1+exp(-2*b*beta));
            new_pattern(j) = sgn(prob_b);
        end
        s = new_pattern;
        
    end
end

