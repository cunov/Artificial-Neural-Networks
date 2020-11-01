function [boardState, iQTable] = MakeMove(qTable,iQTable,boardState,player,epsilon)
    tmpTable = qTable{2,iQTable};
    if rand < epsilon
        validChoice = 0;
        while validChoice == 0
            choice = randi(length(tmpTable));
            if ~isnan(tmpTable(choice))
                boardState(choice) = player;
                break
            end
        end
    else
        [maxVal, choice] = max(tmpTable);
        boardState(choice) = player;
    end
%         iPotentialChoices = (boardState == 0);
%         maxExpectedValue = -Inf;
%         for i = 1:size(qTable,2)
%             for j = iPotentialChoices
%                 potentialBoardState = boardState;
%                 potentialBoardState(j) = player;
%                 if qTable{1,i} == potentialBoardState
%                     for k = 1:9
%                         if qTable{2,i}(k) > maxExpectedValue
%                             maxExpectedValue = qTable{2,i}(k);
%                             bestNewBoardState = potentialBoardState;
%                             iQTable = i;
%                         end
%                     end
%                 end
%             end
%         end 
%         boardState = bestNewBoardState;
    end
%     if boardState(choice) ~= 0
%         error('probblem in MakeMove!')
%     else
%         boardState(choice) = player;
%         for i = 1:size(qTable,2)
%             if boardState == qTable{1,i}
%                 iQTable = i;
%                 break;
%             end
%         end
%     end
end