function [ comb, validationPerf ] = getParamsMLP( cellX, cellT, cellInd )
%GETPARAMSMLP Summary of this function goes here
%   Detailed explanation goes here

idx = 1;
comb = zeros(4,6);
validationPerf = zeros(864,1);

% 864
p1 = 1; % 4
p2 = 1; % 3
p3 = 1; % 3
p4 = 1; % 4
p5 = 1; % 2
p6 = 1; % 3


learningRates = [ 0.01, 0.03, 0.1, 0.4 ];
hiddenNeurons = [ 3, 15, 50 ];
maxEpochs = [ 100, 500, 1000 ];
algorithms = { 'traingd' ; 'trainrp' ; 'trainoss' ; 'trainlm' };
functions = { 'tansig', 'elliotsig' };


for p1=1:4
    for p2=1:1
        for p3=1:1
            for p4=1:1
                for p5=1:1
                    for p6=1:1
                        fprintf('%d\n', idx);
                        rng('default');
                        net = feedforwardnet(hiddenNeurons(p2), algorithms{p4});
                        net.layers{1}.transferFcn = functions{p5};
                        net.trainParam.lr = learningRates(p1);
                        net.trainParam.epochs = maxEpochs(p3);
                        net.trainParam.showWindow = false;
                        
                        net.divideFcn = 'divideind';
                        net.divideParam.trainInd = cellInd{p6,1};
                        net.divideParam.valInd = cellInd{p6,2};
                        net.divideParam.testInd = cellInd{p6,3};
                        
                        [ ~, tr ] = train(net, cellX{p6}', cellT{p6}');
                        validationPerf(idx) = tr.best_vperf;
                        comb(idx,:) = [ p1 p2 p3 p4 p5 p6 ];
                        idx = idx + 1;
                    end;
                end;
            end;
        end;
    end;
end;

end

