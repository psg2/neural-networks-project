main;
Tr = [ base1.class1Tr ; base1.class2Tr ];
Val = [ base1.class1Val ; base1.class2Val ];
Te = [ base1.class1Te ; base1.class2Te ];

Tr(:,8) = Tr(:,7);
Tr(:,7) = ~Tr(:,8);

Val(:,8) = Val(:,7);
Val(:,7) = ~Val(:,8);

Te(:,8) = Te(:,7);
Te(:,7) = ~Te(:,8);

Tr = Tr(randperm(length(Tr)),:);
Val = Val(randperm(length(Val)),:);
Te = Te(randperm(length(Te)),:);

TrValues = Tr(:,1:6);
TrTarget = Tr(:,7:8);
[ ~, TrTarget ] = max(TrTarget, [], 2);
TrTarget = TrTarget - 1;

ValValues = Val(:,1:6);
ValTarget = Val(:,7:8);
[ ~, ValTarget ] = max(ValTarget, [], 2);
ValTarget = ValTarget - 1;

TeValues = Te(:,1:6);
TeTarget = Te(:,7:8);
[ ~, TeTarget ] = max(TeTarget, [], 2);
TeTarget = TeTarget - 1;

X = [ TrValues ; ValValues ; TeValues ]';
T = [ TrTarget ; ValTarget ; TeTarget ]';

TrLen = length(Tr);
ValLen = length(Val);
TeLen = length(Te);

trainInd = 1:TrLen;
valInd = trainInd(end)+1:trainInd(end)+ValLen+1;
testInd = valInd(end)+1:valInd(end)+TeLen+1;

net = feedforwardnet(10, 'traingd');

% net.layers{1}.transferFcn = 'tansig';
net.layers{1}.transferFcn = 'logsig';

net.divideFcn = 'divideind';
net.trainParam.showWindow = false;
net.divideParam.trainInd = trainInd;
net.trainParam.epochs = 10000;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;
[ net, tr ] = train(net, X, T);

y = net(TeValues');
[ ~, classOutput ] = max(y, [], 1);
[ ~, classTarget ] = max(TeTarget, [], 2);
length(find(classOutput' ~= classTarget));


%% Considerando y > 0.5 como classe 1 menor como classe 0. Limiar = 0.5
%% Para mudar é só fazer y > x ( limiar ) 

figure, plotroc(TeTarget', y)
figure, plotconfusion(TeTarget',y)
figure, plotperform(tr)

[~,~,~,AUC] = perfcurve(TeTarget,y',1)


