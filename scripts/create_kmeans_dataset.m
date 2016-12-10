clear
clc

addpath('data');
addpath('functions');

load base_model;

tr_ind = class0.tr_ind;
val_ind = class0.val_ind;
te_ind = class0.te_ind;
X = class0.X;

k_tr = length(class1.tr_ind);
k_val = length(class1.val_ind);

X_training = undersampling_kmeans(X(tr_ind,:), k_tr);
X_validation = undersampling_kmeans(X(val_ind,:), k_val);
X_test = X(te_ind,:);

X_new = [ X_training ; X_validation ; X_test ];

class0.X = X_new;
class0.T = zeros(length(X_new), 1);
class0.n = length(X_new);

[tr_ind, val_ind, te_ind] = create_indexes(X_training, X_validation, X_test);

class0.tr_ind = tr_ind;
class0.val_ind = val_ind;
class0.te_ind = te_ind;

save('data/dataset_kmeans.mat', 'class0', 'class1');
