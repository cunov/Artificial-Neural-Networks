function out = sgn(p_of_b)
%Outputs 1 with probability p_of_b, and -1 with probability 1-p_of_b
    if rand() <= p_of_b
        out = 1;
    else
        out = -1;
    end
end

