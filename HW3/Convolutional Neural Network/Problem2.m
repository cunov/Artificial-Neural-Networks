[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

momentum = .9;
maxEpochs = 30;
miniBatchSize = 8192;
initialLearningRate = 0.01;
validationPatience = 5;
validationFrequency = 30;
options = trainingOptions('sgdm','Momentum',momentum,'MaxEpochs',maxEpochs,...
    'MiniBatchSize',miniBatchSize,'InitialLearnRate',initialLearningRate,...
    'ValidationPatience',validationPatience,'ValidationFrequency',validationFrequency,...
    'Shuffle','every-epoch','ValidationData',{xValid,tValid});

layers = [
    imageInputLayer([28 28 1],"Name","imageinput")
    convolution2dLayer([3 3],20,"Name","conv_1","Padding",1,"Stride",1,"WeightsInitializer","narrow-normal")
    batchNormalizationLayer("Name","batchnorm_1")
    reluLayer("Name","relu_1")
    maxPooling2dLayer([2 2],"Name","maxpool_1","Stride",2,"Padding",0)
    convolution2dLayer([3 3],30,"Name","conv_2","Padding",1,"Stride",1,"WeightsInitializer","narrow-normal")
    batchNormalizationLayer("Name","batchnorm_2")
    reluLayer("Name","relu_2")
    maxPooling2dLayer([2 2],"Name","maxpool_2","Stride",2,"Padding",0)
    convolution2dLayer([3 3],50,"Name","conv_3","Padding",1,"Stride",1,"WeightsInitializer","narrow-normal")
    batchNormalizationLayer("Name","batchnorm_3")
    reluLayer("Name","relu_3")
    fullyConnectedLayer(10,"Name","fc","WeightsInitializer","narrow-normal")
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