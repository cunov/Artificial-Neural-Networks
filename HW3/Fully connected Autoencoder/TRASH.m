tmp = randi([0 1],10000,6);
tmp = unique(tmp,'rows');
size(tmp)
tmp = num2str(tmp);
newTmp = zeros(length(tmp),2);
for i=1:length(tmp)
    temp = strcat('1 ',tmp(i,1:size(tmp,2)/2));
    temp = temp(~isspace(temp));
    newTmp(i,1) = temp
    newTmp(i,2) = [strcat('1 ',tmp(i,1+size(tmp,2)/2:end))];
end