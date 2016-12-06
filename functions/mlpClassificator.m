function [ classificated, erros, net ] = mlpClassificator( params )
%MLPCLASSIFICATOR Summary of this function goes here
%   Detailed explanation goes here

learningRate = params.learningRate;
hiddenNeuron = params.hiddenNeurons;
maxEpoch = params.epochs;
algorithm = params.algorithm;
func = params.func;
X = params.X;
T = params.T;
trInd = params.indTr;
valInd = params.indVal;
teInd = params.indTe;

[ ~, classLabels ] = max(T, [], 2);

net = feedforwardnet(hiddenNeuron, algorithm);
net.layers{1}.transferFcn = func;
net.trainParam.lr = learningRate;
net.trainParam.epochs = maxEpoch;
net.trainParam.showWindow = false;

net.divideFcn = 'divideind';
net.divideParam.trainInd = trInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = teInd;

[ net, tr ] = train(net, X', T');

y = net(X(teInd,:)');

[ ~ , classificated ] = max(y, [], 1);

figure, plotroc(T(teInd,:)', y)
figure, plotconfusion(T(teInd,:)',y)
% figure, plotperform(tr)

erros = length(find(classificated' ~= classLabels(teInd))) / length(teInd);

end

