function s = aSynchronousStochasticUpdate(s,W,N,beta)
%Outputs new_pattern after asynchronously updating input
%pattern s according to weight matrix W, bit-length N, and noise parameter beta 
    i = randi(N);
    
    b = W(i,:)*s';
    prob_b = 1/(1+exp(-2*b*beta));
    s(i) = sgn(prob_b);
end

