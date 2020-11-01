function win = CheckForWin(boardState,player)
    win = 0;
    if boardState(1:3) == player
        win = 1;
    elseif boardState(4:6) == player
        win = 1;
    elseif boardState(7:9) == player
        win = 1;
    elseif boardState(1) == player && boardState(4) == player && boardState(7) == player
        win = 1;
    elseif boardState(2) == player && boardState(5) == player && boardState(8) == player
        win = 1;
    elseif boardState(3) == player && boardState(6) == player && boardState(9) == player
        win = 1;
    elseif boardState(1) == player && boardState(5) == player && boardState(9) == player
        win = 1;
    elseif boardState(3) == player && boardState(5) == player && boardState(7) == player
        win = 1;
    end


%     win = false;
%     for i = 1:3
%         if boardState(i,:) == ones(3,1) * player
%             win = true;
%             return;
%         end
%     end
%     for j = 1:3
%         if boardState(:,j) == ones(1,3) * player
%             win = true;
%             return;
%         end
%     end
%     
%     diagonalCount = 0;
%     if boardState(1,1) == player && diagonalCount(2,2) == player && diagonalCount(3,3) == player
%         win = true;
%         return;
%     end
%     if boardState(1,3) == player && diagonalCount(2,2) == player && diagonalCount(3,1) == player
%         win = true;
%         return;
%     end
    
end

