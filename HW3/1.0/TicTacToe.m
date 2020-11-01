
clear all

q1 = cell(2,1);
q2 = cell(2,1);
e1 = 1;
e2 = 1;
nOfGames = 30000;
playerX = 1;
playerO = -1;
a = 0.1;
gamma = 1.0;

boardStateO = [0,0,0,
               0,0,0,
               0,0,0];

winCount = 0;
k = 0;     
progress = 0;
maximumStates = 4520;
 
while progress < 100.000
    
    %% ------------------------ INIT  GAME --------------------------------
    if mod(k,100) == 0 && k > 10000
        e1 = e1*0.99;
        e2 = e2*0.99; 
        
        if 100*(length(q1(1,:))+length(q2(1,:)))/maximumStates > progress
        progress = 100*(length(q1(1,:))+length(q2(1,:)))/maximumStates;
        fprintf('Discovered States: %3.3f percent\n',progress)
      
        end
    end
    
    boardStateO = [0,0,0,
                   0,0,0,
                   0,0,0];
   
    gameOngoing = true;
    win = NaN;
    currentStateIndex_X = 1;
    currentStateIndex_O = 1;

    while gameOngoing
        
        %% ------------------- TURN PLAYER X ------------------------------
        currentState = boardStateO;
        
        oldStateIndex_X = currentStateIndex_X;
        [q1,currentStateIndex_X]= AppendQTable(q1,currentState);
        
        q1 = UpdateTables(q1,win,NaN,oldStateIndex_X,currentStateIndex_X,a,playerX,gamma); 
        
        boardStateX =  GetNextTurn(currentState,q1,e1,playerX);
        
        %PrintState(boardStateX);
        
        win = CheckForWin(boardStateX,playerX);
        if ~isnan(win)
         if win == 1
%                  fprintf('Game #%1.1i: Win\n',g)            
         end
             winCount = winCount + win;
            
            terminateStateX = boardStateX;
            oldStateIndex_X = currentStateIndex_X; 
            oldStateIndex_O = currentStateIndex_O; 
            terminateStateO = boardStateO;
                       
            q1 = UpdateTables(q1,win,terminateStateX,oldStateIndex_X,currentStateIndex_X,a,playerX,gamma);
            q2 = UpdateTables(q2,win,terminateStateO,oldStateIndex_O,currentStateIndex_O,a,playerO,gamma);            
            break;
        else
            
        end
        
        %% ------------------- TURN PLAYER O ------------------------------
        currentState = boardStateX;
        
        oldStateIndex_O = currentStateIndex_O;
        [q2,currentStateIndex_O] = AppendQTable(q2,currentState);
        
        q2 = UpdateTables(q2,win,NaN,oldStateIndex_O,currentStateIndex_O,a,playerO,gamma);
        
        boardStateO =  GetNextTurn(currentState,q2,e2,playerO);
        
        %PrintState(boardStateO);
        
        win = CheckForWin(boardStateO,playerO);
        if ~isnan(win)
 
        if win == -1
     %        fprintf('Game #%1.1i: Loss\n',k)
        elseif win == 0
                 fprintf('Game #%1.1i: O-Draw\n',k)            
        end
             
            terminateStateO = boardStateO;           
            oldStateIndex_O = currentStateIndex_O; 
            oldStateIndex_X = currentStateIndex_X; 
            terminateStateX = boardStateX;
   
            
            q1 = UpdateTables(q1,win,terminateStateX,oldStateIndex_X,currentStateIndex_X,a,playerX,gamma);
            q2 = UpdateTables(q2,win,terminateStateO,oldStateIndex_O,currentStateIndex_O,a,playerO,gamma);             
            break;
        end
        
        
    
    end
k=k+1;
end

csvwrite('player1.csv',q1)
csvwrite('player2.csv',q2)





