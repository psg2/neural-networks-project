clear
clc

addpath('data');

mat = xlsread('mammography-consolidated');

[ ~, idx ] = unique(mat, 'rows');

X = mat(idx,1:end-1);
T = mat(idx,end);

save('data/dataset.mat', 'X', 'T');