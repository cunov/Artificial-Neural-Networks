X = readmatrix('X.txt'); % A matrix (csv format) file where each row is a pattern i.e. 1st row is pattern "0", 2nd row is pattern "1", ...

% These are in csv format, with one line of N digits
% test_pattern = readmatrix('test_pattern1.txt');
% test_pattern = readmatrix('test_pattern2.txt'); 
test_pattern = readmatrix('test_pattern3.txt'); 

sizeX = size(X);
p = sizeX(1);
N = sizeX(2);
W = (X'*X - p*eye(N))/N;

converged = 0;
cnt = 0;
while converged == 0
    [test_pattern, converged] = aSynchronousUpdate(test_pattern,W,N);
end

state = 6;
digit = NaN;
for i=1:p
    if isequal(X(i,:),test_pattern)
        formatted_pattern = reshape(test_pattern,10,16)';
        state = i;
        digit = i - 1;
        writematrix(formatted_pattern,'formatted_pattern.csv');
        break
    elseif  isequal(-1*X(i,:),test_pattern)
        formatted_pattern = reshape(test_pattern,10,16)';
        state = -i;
        digit = i - 1;
        writematrix(formatted_pattern,'formatted_pattern.csv');
        break
    end
end

disp('The pattern is classified as state:')
disp(state)
if ~isnan(digit)
    if state > 0
        disp('The pattern converged to the digit:')
    else
        disp('The pattern converged to the INVERSE of digit:')
    end
    disp(digit)
else
    disp('The pattern did not converge to any stored pattern or its inverse')
end