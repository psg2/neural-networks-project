clear
clc

addpath('data');
addpath('functions');

load dataset_normalized;

tr_rate = 50;
val_rate = 25;
te_rate = 25;

class0 = struct();
class1 = struct();

class0.X = X(T==0,:);
class0.T = T(T==0,:);

class1.X = X(T==1,:);
class1.T = T(T==1,:);

class0.n = length(class0.X);
class1.n = length(class1.X);

[tr_ind, val_ind, te_ind] = dividerand(class0.n, tr_rate, val_rate, te_rate);

class0.tr_ind = tr_ind;
class0.val_ind = val_ind;
class0.te_ind = te_ind;

[tr_ind, val_ind, te_ind] = dividerand(class1.n, tr_rate, val_rate, te_rate);

class1.tr_ind = tr_ind;
class1.val_ind = val_ind;
class1.te_ind = te_ind;

save('data/base_model.mat', 'class0', 'class1');
