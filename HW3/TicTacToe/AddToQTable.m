function qTable = AddToQTable(qTable,boardState,initialEstimatedVal)
    append = true;
    for i = 1:size(qTable,2)
        if isequal(qTable{1,i} , boardState)
            append = false;
            break;
        end
    end
    if append == true
        qTable{1,size(qTable,2) + 1} = boardState;
        qTable{2,size(qTable,2)} = InitializeRewardTable(boardState,initialEstimatedVal);
    end
end

