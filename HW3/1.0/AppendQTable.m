function [qT stateIndex] = AppendQTable(qTable,boardState)

    qT = qTable;  
    
    if isempty(qTable{1,1})
        qT{1,1} = boardState;
        qT{2,1} = ConvertState(boardState);
        stateIndex = 1;
        return
    end
    
    
    for i=1:length(qTable(1,:))
        if boardState == qTable{1,i}
            stateIndex = i;
            return
        end
    end
    
        qT = qTable;
        qT{1,end+1} = boardState;          
        qT{2,end} = ConvertState(boardState);
        stateIndex = i+1;
end