function [new_pattern, isSame] = aSynchronousUpdateOLD(s,W,N)
%Outputs [new_pattern, isSame] where new_pattern is an asynchronously
% updated pattern s according to matrix W and bit-length N and isSame=1 if
% steady state is reached, 0 otherwise
    indices = 1:N;
    randIndices = indices(randperm(N));
    new_pattern = s;
    for i=randIndices
        b = W(i,:)*new_pattern';
        new_pattern(i) = sgn(b);
    end
    
    isSame = isequal(new_pattern,s);
end