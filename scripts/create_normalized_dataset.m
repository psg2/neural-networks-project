clear
clc

addpath('data');
addpath('functions');

load dataset;

X = normalize(X);

save('data/dataset_normalized.mat', 'X', 'T');
