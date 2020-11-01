function initArray = ConvertState(boardState)
initArray = zeros(3);
    for i=1:3
        for j =1:3
            if boardState(i,j) ~= 0
                initArray(i,j) = NaN;
            end
        end
    end    
end