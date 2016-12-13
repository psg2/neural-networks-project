clear
clc

addpath('data');
addpath('functions');

load base_model;

tr_ind = class1.tr_ind;
val_ind = class1.val_ind;
te_ind = class1.te_ind;
X = class1.X;
X_class0 = class0.X;

k_tr = floor( length(class0.tr_ind) / length(class1.tr_ind) );
k_val = floor( length(class0.val_ind) / length(class1.val_ind) );
lim_tr = length(class0.tr_ind);
lim_val = length(class0.val_ind);
divisor_tr = length(tr_ind);
divisor_val = length(val_ind);

X_training = adapted_smote([ X(tr_ind,:) ; X_class0 ], divisor_tr, 5, lim_tr, k_tr);
X_validation = adapted_smote([ X(val_ind,:) ; X_class0 ], divisor_val, 5, lim_val, k_val);
X_test = X(te_ind,:);

X_new = [ X_training ; X_validation ; X_test ];
X_new2 = unique(X_new, 'rows');

class1.X = X_new;
class1.T = ones(length(X_new), 1);
class1.n = length(X_new);

[tr_ind, val_ind, te_ind] = create_indexes(X_training, X_validation, X_test);

class1.tr_ind = tr_ind;
class1.val_ind = val_ind;
class1.te_ind = te_ind;

save('data/dataset_adapted_smote.mat', 'class0', 'class1');
