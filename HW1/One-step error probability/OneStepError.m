function out = OneStepError(pattern,W,N,i)
% Outputs 1 if a single updated bit on input pattern matches old bit, 0 otherwise, 
%    according to inputs weighted matrix W, bit length N, and index i
    sum = W(i,:)*pattern';
    if sgn(sum) ~= pattern(i)
        out = 0;
    else
        out = 1;
    end
end