clc
clear

load dataSets

[ comb, validationPerf ] = getParamsMLP(cellX, cellT, cellInd);

learningRates = [ 0.01, 0.03, 0.1, 0.4 ];
hiddenNeurons = [ 3, 15, 50 ];
maxEpochs = [ 100, 500, 1000 ];
algorithms = { 'traingd' ; 'trainrp' ; 'trainoss' ; 'trainlm' };
functions = { 'tansig', 'elliotsig' };

params.learningRate = learningRates(1);
params.hiddenNeurons = hiddenNeurons(1);
params.epochs = maxEpochs(1);
params.algorithm = algorithms{1};
params.func = functions{1};
params.X = cellX{1};
params.T = cellT{1};
params.indTr = cellInd{1,1};
params.indVal = cellInd{1,2};
params.indTe = cellInd{1,3};

mlpClassificator(params);