i=1;
x(i) = 0.075;
x(i+1) = Inf;
while x(end) - x(end-1) > 10^-5
    i = i+1;
    x(i) = x(i-1) - (8 - x(i-1)^-1)/(x(i-1)^-2);
end
x