function win = CheckForWin(boardState,player)
win = NaN;
%check cross win
if boardState(1,1)+boardState(2,2)+boardState(3,3) == 3*player
    win = player;
    return;
elseif boardState(1,3)+boardState(2,2)+boardState(3,1) == 3*player
    win = player;
    return;
end
    for i=1:3
        for j=1:3
            % win by rows
            if sum(boardState(i,:)) == 3*player
                win = player;
                break;
            end
            % win by cols
            if sum(boardState(:,j)) == 3*player
                win = player;
                break;
            end
        end
    end
    
    tilesLeft = sum(sum(boardState==0)); 
    
    if isnan(win) && tilesLeft == 0 
        win = 0;
    end
end