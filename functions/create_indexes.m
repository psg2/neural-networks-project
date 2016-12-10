function [ tr_ind, val_ind, te_ind ] = create_indexes( tr, val, te )
%CREATE_INDICES Summary of this function goes here
%   Detailed explanation goes here

tr_size = length(tr);
val_size = length(val);
te_size = length(te);

temp = 1;
tr_ind = temp:(tr_size);
temp = tr_ind(end) + 1;
val_ind = temp:( temp + val_size - 1);
temp = val_ind(end) + 1;
te_ind = temp:(temp + te_size - 1);


end

