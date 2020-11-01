function m = Calculate_m(s,x,N)
%Calculates m(t) given test pattern (s), original test pattern (x), and
%bit-length N
    m = (1/N) * s * x';
end

