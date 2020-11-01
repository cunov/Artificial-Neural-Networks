clear all
dat = LoadData();
numVisibleNeurons = 9;
numPatterns = 14;
learningRate = .01;
K = 100;
numIterations = 200;
DKL = zeros(4,numIterations);

iHiddenNeuron = 1;
for numHiddenNeurons=[2 4 8 16]
    W = InitializeWeights(numVisibleNeurons,numHiddenNeurons);
    biasH = InitializeBiases(numHiddenNeurons);
    biasV = InitializeBiases(numVisibleNeurons);
    for T = 1:numIterations
        tmp = randperm(numPatterns);
        p0 = randi(numPatterns);
        p0 = tmp(1:p0);
        for mu = p0
            
            pattern = dat(mu,:)';
            [v0, vK, bH0, bHK] = IterateDynamics(pattern,W,biasV,biasH,K);
            
            tmp1 = tanh(bH0) * v0';
            tmp2 = tanh(bHK) * vK';
            deltaW{mu} = learningRate * (tmp1 - tmp2);
            deltaBiasH{mu} = -learningRate * (tanh(bH0)-tanh(bHK))';
            deltaBiasV{mu} = -learningRate * (v0 - vK);
        end
        for mu = p0
            W = W + deltaW{mu};
            biasH = biasH + deltaBiasH{mu};
            biasV = biasV + deltaBiasV{mu};
        end
        PB = EstimateBoltzmannDistn(W,biasV,biasH,dat);
        DKL(iHiddenNeuron,T) = CalculateDKL(PB);
        plot(1:numIterations,DKL(1,:),'b',1:numIterations,DKL(2,:),'r',1:numIterations,DKL(3,:),'g',1:numIterations,DKL(4,:),'k');
        disp(strcat(num2str(iHiddenNeuron),'-',num2str(T),'---',num2str(DKL(iHiddenNeuron,T))));
    end
    iHiddenNeuron = iHiddenNeuron + 1;
end
