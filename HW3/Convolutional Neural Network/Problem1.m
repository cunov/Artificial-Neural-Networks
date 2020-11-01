[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

momentum = .9;
maxEpochs = 60;
miniBatchSize = 8192;
initialLearningRate = 0.001;
validationPatience = 5;
validationFrequency = 30;

options = trainingOptions('sgdm','Momentum',momentum,'MaxEpochs',maxEpochs,...
    'MiniBatchSize',miniBatchSize,'InitialLearnRate',initialLearningRate,...
    'ValidationPatience',validationPatience,'ValidationFrequency',validationFrequency,...
    'Shuffle','every-epoch','ValidationData',{xValid,tValid});

layers = [
    imageInputLayer([28 28 1],"Name","imageinput")
    convolution2dLayer([5 5],20,"Name","conv","Padding",1,"WeightsInitializer","narrow-normal")
    reluLayer("Name","relu_1")
    maxPooling2dLayer([2 2],"Name","maxpool","Stride",1,"padding",0)
    fullyConnectedLayer(100,"Name","fc_1","WeightsInitializer","narrow-normal")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(10,"Name","fc_2","WeightsInitializer","narrow-normal")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

net = trainNetwork(xTrain,tTrain,layers,options);

tTrainPred = classify(net,xTrain);
tValPred = classify(net,xValid);
tTestPred = classify(net,xTest);

trainConfusion = confusionmat(tTrain,tTrainPred);
validConfusion = confusionmat(tValid,tValPred);
testConfusion = confusionmat(tTest,tTestPred);
diagTrain = diag(trainConfusion);
diagValid = diag(validConfusion);
diagTest = diag(testConfusion);
for i = 1:10
    iTrainError(i) = (sum(trainConfusion(i,:)) - diagTrain(i)) / sum(trainConfusion(:));
    iValidError(i) = (sum(validConfusion(i,:)) - diagValid(i)) / sum(validConfusion(:));
    iTestError(i) = (sum(testConfusion(i,:)) - diagTest(i)) / sum(testConfusion(:));
end
trainError = 1 - sum(tTrain==tTrainPred) / length(tTrain);
validError = 1 - sum(tValid==tValPred) / length(tValid);
testError = 1 - sum(tTest==tTestPred) / length(tTest);
