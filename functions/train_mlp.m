function [ performances ] = train_mlp( params )
%MLPCLASSIFICATOR Summary of this function goes here
%   Detailed explanation goes here

learning_rate = params.learning_rate;
hidden_neuron = params.hidden_neuron;
max_epoch = params.max_epoch;
algorithm = params.algorithm;
transfer_function = params.transfer_function;
X = params.X;
T = params.T;
tr_ind = params.tr_ind;
val_ind = params.val_ind;
te_ind = params.te_ind;
max_fail = params.max_fail;

net = feedforwardnet(hidden_neuron, algorithm);
net.layers{1}.transferFcn = transfer_function;
net.trainParam.lr = learning_rate;
net.trainParam.epochs = max_epoch;
net.trainParam.max_fail = max_fail;
net.trainParam.showWindow = false;

net.divideFcn = 'divideind';
net.divideParam.trainInd = tr_ind;
net.divideParam.valInd = val_ind;
net.divideParam.testInd = te_ind;

[ net, tr ] = train(net, X', T');

y = net(X(te_ind,:)');

[ ~, ~, ~, AUC ] = perfcurve(T(te_ind,:)', y, 1);

tr_perf = tr.best_perf;
val_perf = tr.best_vperf;
te_perf = tr.best_tperf;

performances = { AUC, tr_perf, val_perf, te_perf, y, T(te_ind,:)' };

% tr

% erros = length(find(classificated' ~= classLabels(te_ind))) / length(te_ind);
% [ ~ , classificated ] = max(y, [], 1);
% figure, plotroc(te, y)
% figure, plotconfusion(te,y)
% figure, plotperform(tr)

end

