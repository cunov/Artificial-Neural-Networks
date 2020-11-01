function rewardTable = InitializeRewardTable(boardState,initialEstimatedVal)
    rewardTable = ones(1,9) * initialEstimatedVal;
    for i = 1:9
        if boardState(i) ~= 0
            rewardTable(i) = NaN;
        end
    end
end

