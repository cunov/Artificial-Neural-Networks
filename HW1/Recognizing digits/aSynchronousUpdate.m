function [new_pattern, isSame] = aSynchronousUpdate(s,W,N)
%Outputs [new_pattern, isSame] where new_pattern is an asynchronously
% updated pattern s according to matrix W and bit-length N and isSame=1 if
% steady state is reached, 0 otherwise
    new_pattern = s;
    neuronsChecked = zeros(1,N); % 1 if neuron at index i has been checked, 0 otherwise
    
    while ismember(0,neuronsChecked)
        i = randi(N);
        if neuronsChecked(i) == 0
            neuronsChecked(i) = 1;
        end
        b = W(i,:)*new_pattern';
        new_pattern(i) = sgn(b);
    end

    isSame = isequal(new_pattern,s);
end