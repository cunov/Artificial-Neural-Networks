[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);
xTrainAdj = reshape(xTrain,784,[]) / 255;
xValidAdj = reshape(xValid,784,[]) / 255;
xTestAdj = reshape(xTest,784,[]) / 255;

miniBatchSize = 8192;
initialLearningRate = 0.001;
shuffle = 'every-epoch';
maxEpochs = 800;
executionEnvironment = 'gpu';

options = trainingOptions('adam','MaxEpochs',maxEpochs,...
    'MiniBatchSize',miniBatchSize,'InitialLearnRate',initialLearningRate,...
    'Shuffle',shuffle,'ValidationData',{xValidAdj,xValidAdj},'ExecutionEnvironment',executionEnvironment);

layers1 = [
    sequenceInputLayer(784,"Name","sequence","Normalization","rescale-zero-one")
    fullyConnectedLayer(50,"Name","fc_1","WeightsInitializer","glorot")
    reluLayer("Name","relu_1")
    fullyConnectedLayer(2,"Name","fc_2","WeightsInitializer","glorot")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(784,"Name","fc_3","WeightsInitializer","glorot")
    reluLayer("Name","relu_3")
    regressionLayer("Name","regressionoutput")];

layers2 = [
    sequenceInputLayer(784,"Name","sequence","Normalization","rescale-zero-one")
    fullyConnectedLayer(50,"Name","fc_1","WeightsInitializer","glorot")
    reluLayer("Name","relu_1")
    fullyConnectedLayer(4,"Name","fc_2","WeightsInitializer","glorot")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(784,"Name","fc_3","WeightsInitializer","glorot")
    reluLayer("Name","relu_3")
    regressionLayer("Name","regressionoutput")];

net1 = trainNetwork(xTrainAdj,xTrainAdj,layers1,options);
save net1
net2 = trainNetwork(xTrainAdj,xTrainAdj,layers2,options);
save net2

foundTen = 0;
found = cell(10,1);
i=1;
while foundTen ~= 10
    digit = tTrain(i);
    if isempty(found{digit})
        found{digit} = xTrainAdj(:,i);
        foundTen = foundTen + 1;
    end
    i = i + 1;
end        
digits = found;

net1output = cell(10,1);
net2output = cell(10,1);
digi = 0;
for i=1:3:30
    net1output{digi+1} = reshape(predict(net1,digits{digi+1}),28,28);
    net2output{digi+1} = reshape(predict(net2,digits{digi+1}),28,28);
    subplot(10,3,i)
    h = imshow(mat2gray(reshape(digits{digi+1},28,28)),'border','tight');
    title(strcat('[',num2str(digi),'] - Original'));
    subplot(10,3,i+1)
    h = imshow(net1output{digi+1},'border','tight');
    title(strcat('[',num2str(digi),'] - Network 1'));
    subplot(10,3,i+2)
    h = imshow(net2output{digi+1},'border','tight');
    title(strcat('[',num2str(digi),'] - Network 2'));
    digi = digi + 1;
end

layers_encode1(1) = net1.Layers(1);
layers_encode1(2) = net1.Layers(2);
layers_encode1(3) = net1.Layers(3);
layers_encode1(4) = net1.Layers(4);
layers_encode1(5) = net1.Layers(5);
layers_encode1(6) = regressionLayer("Name","regressionoutput");
net1_encode = assembleNetwork(layers_encode1);

layers_decode1(1) = sequenceInputLayer(2);
layers_decode1(2) = net1.Layers(6);
layers_decode1(3) = net1.Layers(7);
layers_decode1(4) = net1.Layers(8);
net1_decode = assembleNetwork(layers_decode1);

layers_encode2(1) = net2.Layers(1);
layers_encode2(2) = net2.Layers(2);
layers_encode2(3) = net2.Layers(3);
layers_encode2(4) = net2.Layers(4);
layers_encode2(5) = net2.Layers(5);
layers_encode2(6) = regressionLayer("Name","regressionoutput");
net2_encode = assembleNetwork(layers_encode2);

layers_decode2(1) = sequenceInputLayer(4);
layers_decode2(2) = net2.Layers(6);
layers_decode2(3) = net2.Layers(7);
layers_decode2(4) = net2.Layers(8);
net2_decode = assembleNetwork(layers_decode2);

scat = [];
colorMap = [];
predictEncode1 = predict(net1_encode,xTrainAdj(:,:));
for i = 1:1500
    scat = [scat; double(tTrain(i))-1 double(predictEncode1(:,i))'];
    if ismember(double(tTrain(i)), [1 2])
        if double(tTrain(i)) == 1
            colorMap = [colorMap; [1 0 0]];
        else
            colorMap = [colorMap; [0 0 1]];
        end
    else
        colorMap = [colorMap; [.5 .5 .5]];
    end
end
scatter(scat(:,2),scat(:,3),24* ones(2, 1),colorMap,'filled')
xlabel('Neuron 1')
ylabel('Neuron 2')
title('1 is in red, 0 is in blue')


zeros = [[10,6];[8,4];[11,9]];
ones = [[1,4];[.5,8];[3,9]];
tmp = 0;
for i = 1:2:6
    tmp = tmp + 1;
    subplot(6,2,i)
    imshow(reshape(predict(net1_decode,zeros(tmp,:)'),28,28));
    subplot(6,2,i+1)
    imshow(reshape(predict(net1_decode,ones(tmp,:)'),28,28));
end

scat = [];
colorMap = [];
predictEncode2 = predict(net2_encode,xTrainAdj(:,:));
scat = [double(tTrain(:))-1 double(predictEncode2)'];
scat = scat(ismember(scat(:,1),[0 1 3 7]),:);
% for i = 1:length(predictEncode2)
%     scat = [scat; double(tTrain(i))-1 double(predictEncode2(:,i))'];
% end
scatter(scat(:,2),scat(:,3),24* ones(2, 1),colorMap,'filled')
xlabel('Neuron 1')
ylabel('Neuron 2')
title('7 is in green, 1 is in red, 0 is in blue')

zero = [     0    3.7038    5.2611         0; 6.0080   10.5181   13.1277    9.7530];
one = [6.2897   10.5740   13.4334    9.7849; 10.0656   13.9569   22.5476   15.9427];
seven = [10.0720   14.0050   22.5671   16.4489; 20.5541   19.3914   29.7861   23.2944];
subplot(3,2,1)
imshow(reshape(predict(net2_decode,zero(1,:)),28,28))