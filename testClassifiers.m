clear
clc
load abalone.mat

X = abalone(:,2:9);
T = abalone(:,1);

len = length(T);
k = max(T);
Te = zeros(len, k);

for i=1:len
    Te(i,T(i)) = 1;
end;


CVO = cvpartition(T, 'KFold', 10);

% classificated = zeros(10, 4);
erros = zeros(10, 4);

fprintf('Pegando os parâmetros para MLP\n');
params = getParamsMLP(X, Te);

fprintf('Inicializando treinamento e testes dos classificadores com Cross Validation KFold\n');
for i=1:CVO.NumTestSets
    fprintf('Fold %d\n', i);
    teIndLogical = CVO.test(i);
    trIndLogical = CVO.training(i);
    
    trInd = find(trIndLogical==1);
    teInd = find(teIndLogical == 1);
    
    testData = X(teInd, :);
    testClasses = T(teInd, :);
    trainData = X(trInd, :);
    trainClasses = T(trInd, :);
    
    trSize = CVO.TrainSize(i);
    percentageVal = round(trSize * 0.2);
    valInd = trInd(end-percentageVal:end,:);
    trIndMLP = trInd(1:end-percentageVal,:);
    
    [ classificatedBayes, erros(i,1), ~ ] = ...
        mvnpdfClassificator(testData, testClasses, trainData, trainClasses);
    
    [ classificatedSVM, erros(i,2) ] = ...
        svmClassificator(testData, testClasses, trainData, trainClasses);
    
    [ classificatedMLP, erros(i,3) ] = ...
        mlpClassificator(X, Te, trIndMLP, valInd, teInd, params);
    
    estimatedClass = [ classificatedBayes, classificatedSVM ];
    
    [ classificatedMajoritario, erros(i,4), ~ ] = ...
        Majoritario(estimatedClass, testClasses);
   
end;

intervaloConfiancaBayes = intervaloConfianca(erros(:,1), 0.05, 'Bayes');
intervaloConfiancaSVM = intervaloConfianca(erros(:,2), 0.05, 'SVM');
intervalConfiancaMLP = intervaloConfianca(erros(:,3), 0.05, 'MLP');
intervaloConfiancaMajoritario = intervaloConfianca(erros(:,4), 0.05, 'Voto Majoritário');

F = friedman(erros, 1, 'off');