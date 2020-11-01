function nextTurn = GetNextTurn(currentState,qTable,e,player)

    nextTile = 0;
    bestTile = -Inf;
    nextTurn = currentState;
    
    for i=1:length(qTable(1,:))
        if currentState == qTable{1,i}
                currentStateIndex = i;
            break
        end
    end
    
    probMatrix = qTable{2,currentStateIndex}(~isnan(qTable{2,currentStateIndex}));
    r = rand;
    
    if r < e || range(probMatrix) == 0
        % pick random tile
        while nextTile == 0
            tileX = randi([1,3]);
            tileY = randi([1,3]);
            if currentState(tileX,tileY) == 0
                nextTile = [tileX,tileY];
            end
        end
        
    else    
        % pick highest tile
        n = 0;
        
        for i=1:3
            for j=1:3
                if qTable{2,currentStateIndex}(i,j) >= bestTile
                    n = n+1;
                    if qTable{2,currentStateIndex}(i,j) > bestTile
                        n = 1;
                        nTile = [];
                        nTile(n,:) = [i,j];
                        bestTile = qTable{2,currentStateIndex}(i,j);
                    else                        
                        nTile(n,:) = [i,j];
                    end
                end
            end
        end
        chosen = randi(length(nTile(:,1)));
        tileX = nTile(chosen,1); 
        tileY = nTile(chosen,2); 
        
         
    end
    nextTurn(tileX,tileY) = player;
end