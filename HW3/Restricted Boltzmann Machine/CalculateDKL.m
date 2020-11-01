function DKL = CalculateDKL(PB)
    DKL = 0;
    for mu = 1:14
        DKL = DKL + (1/14)*log((1/14)/PB(mu));
    end
end

