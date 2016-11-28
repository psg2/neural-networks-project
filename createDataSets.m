clc;
clear;

trR = 50;
valR = 25;
teR = 25;

% mat = xlsread('mammography-consolidated.xlsx');
% mat = unique(mat, 'rows');

load cancerDataNorm.mat;

mat = cancerDataNorm;

[ class1, class2 ] = divideClass(mat);

[ class1Tr, class1Val, class1Te ] = divideSets(class1, trR, valR, teR);
[ class2Tr, class2Val, class2Te ] = divideSets(class2, trR, valR, teR);

cellX = { };
cellT = { };
cellInd = { };


%% Base de dados 1 Classe Majoritária reduzida %%

class1TrSize = length(class1Tr);
class1ValSize = length(class1Val);
class2TrSize = length(class2Tr);
class2ValSize = length(class2Val);
class1TeSize = length(class1Te);
class2TeSize = length(class2Te);

class2TrUnderSampled = underSampleKMeans(class2Tr, class1TrSize);
class2ValUnderSampled = underSampleKMeans(class2Val, class1TrSize);

data = [ class1Tr ;  class2TrUnderSampled ; class1Val ; ...
    class2ValUnderSampled ; class1Te ; class2Te ];

temp = 1;
trInd = temp:(class1TrSize + length(class2TrUnderSampled));
temp = trInd(end) + 1;
valInd = temp:( temp + class1ValSize + length(class2ValUnderSampled) - 1);
temp = valInd(end) + 1;
teInd = temp:(temp + class1TeSize + class2TeSize - 1);

cellX{1} = data(:,1:end-1);
cellT{1} = data(:, end);
cellInd{1,1} = trInd;
cellInd{1,2} = valInd;
cellInd{1,3} = teInd;

%% Base de dados 1 Classe Minoritária aumentada SMOTE %%

k = floor(class2TrSize / class1TrSize);

class1TrOversampled = smote(class1Tr, k);
class1ValOversampled  = smote(class1Val, k);

class1TrOversampled = class1TrOversampled(1:class2TrSize,:);
class1ValOversampled = class1ValOversampled(1:class2ValSize,:);

data = [ class1TrOversampled ; class2Tr ;  class1ValOversampled ; class2Val ; class1Te ; class2Te ];

temp = 1;
trInd = temp:(class2TrSize + length(class1TrOversampled));
temp = trInd(end) + 1;
valInd = temp:( temp + class2ValSize + length(class1ValOversampled) - 1);
temp = valInd(end) + 1;
teInd = temp:(temp + class1TeSize + class2TeSize - 1);

cellX{2} = data(:,1:end-1);
cellT{2} = data(:, end);
cellInd{2,1} = trInd;
cellInd{2,2} = valInd;
cellInd{2,3} = teInd;

%% Base de dados 1 Classe Minoritária aumentada SMOTE Adaptado %%

k = floor(class2TrSize / class1TrSize);

class1TrOversampledAdaptado = smoteAdaptado([class1Tr ; class2 ], class1TrSize, k, 1);
class1ValOversampledAdaptado  = smoteAdaptado([ class1Val ; class2 ], class1ValSize, k, 1);

class1TrOversampledAdaptado = class1TrOversampledAdaptado(1:class2TrSize,:);
class1ValOversampledAdaptado = class1ValOversampledAdaptado(1:class2ValSize,:);

data = [ class1TrOversampledAdaptado ; class2Tr ; class1ValOversampledAdaptado ; class2Val ; class1Te ; class2Te];

temp = 1;
trInd = temp:(class2TrSize + length(class1TrOversampledAdaptado));
temp = trInd(end) + 1;
valInd = temp:( temp + class2ValSize + length(class1ValOversampledAdaptado) - 1);
temp = valInd(end) + 1;
teInd = temp:(temp + class1TeSize + class2TeSize - 1);

cellX{3} = data(:,1:end-1);
cellT{3} = data(:, end);
cellInd{3,1} = trInd;
cellInd{3,2} = valInd;
cellInd{3,3} = teInd;

save('dataSets.mat', 'cellX', 'cellT', 'cellInd');



