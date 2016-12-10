function [ X, T, tr_ind, val_ind, te_ind ] = prepare_data( class0, class1 )
%PREPARE_DATA Summary of this function goes here
%   Detailed explanation goes here

X_0 = [ class0.X class0.T ];
X_1 = [ class1.X class1.T ];

tr_ind_0 = class0.tr_ind;
val_ind_0 = class0.val_ind;
te_ind_0 = class0.te_ind;

tr_ind_1 = class1.tr_ind;
val_ind_1 = class1.val_ind;
te_ind_1 = class1.te_ind;

tr = [ X_0(tr_ind_0,:) ; X_1(tr_ind_1,:) ];
val = [ X_0(val_ind_0,:) ; X_1(val_ind_1,:) ];
te = [ X_0(te_ind_0,:) ; X_1(te_ind_1,:) ];

tr = tr(randperm(length(tr)),:);
val = val(randperm(length(val)),:);
te = te(randperm(length(te)),:);

X = [ tr ; val ; te ];

[ tr_ind, val_ind, te_ind ] = create_indexes(tr, val, te);

T = X(:,end);
X = X(:,1:end-1);

end

