function qTable = UpdateTables(qT,win,winningState,oldStateIndex,currentStateIndex,a,player,gamma)

    qTable = qT;
 

                
if isnan(win)
        reward = 0;

       oldState = qTable{1,oldStateIndex};
       currentState = qTable{1,currentStateIndex};

       dif = currentState - oldState;
           
       if ~isempty(dif)
            for i=1:3
                for j=1:3
                    if dif(i,j) == player                        
                        k = i;
                        l = j;
                        qTable{2,oldStateIndex}(k,l) = qTable{2,oldStateIndex}(k,l) + a*(reward + ( gamma*max(max(qTable{2,currentStateIndex})) - qTable{2,oldStateIndex}(k,l)));
                        return;
                    end
                end
            end 
       else
           return
       end
                
        
else
        reward = win*player;
        oldState = qTable{1,oldStateIndex};
        currentState = winningState;

       dif = currentState - oldState;
            
        for i=1:3
            for j=1:3
                if dif(i,j) == player                        
                    k = i;
                    l = j;
                    qTable{2,oldStateIndex}(k,l) = qTable{2,oldStateIndex}(k,l) + a*(reward - qTable{2,oldStateIndex}(k,l));                        
                    return;
                end
            end
        end
           
        
    end
end


