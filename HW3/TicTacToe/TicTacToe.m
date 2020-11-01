clear all
initialBoardState = [0,0,0,0,0,0,0,0,0];
epsilon0 = .5;
epsilonFin = .02;
playerO = 1;
playerX = -1;
initialEstimatedVal = .7;

playerOWins = 0;
playerXWins = 0;
draws = 0;

qTableX = cell(2,1); % first row is board, 2nd is expected values\
qTableO = cell(2,1);
boardState = initialBoardState;
qTableX{1,1} = initialBoardState;
qTableX{2,1} = initialEstimatedVal * ones(1,9);
qTableO{1,1} = initialBoardState;
qTableO{2,1} = initialEstimatedVal * ones(1,9);


for iGame = 1:100000
    % initialize game
    gameOnGoing = 1;
    boardState = initialBoardState;
    iQTableO = 1; iQTableX = 1;
    while gameOnGoing == 1
        [boardState iQTableO] = MakeMove(qTableO,iQTableO,boardState,playerO);
        gameOnGoing = CheckForWin(boardState,playerO);
        if gameOnGoing == 0
            qTableO = UpdateQTable(qTableO);
            qTableX = UpdateQTable(qTableX);
        else
            boardState = MakeMove(boardState,playerX);
            gameOnGoing = CheckForWin(boardState,playerX);
            if gameOnGoing == 0
                qTableO = UPdateQTable(qTableO);
                qTableX = UpdateQTable(qTableX);
            end
        end
    end
end
    
        