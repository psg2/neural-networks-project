function [ trS, valS, teS ] = divideSets( mat, trR, valR, teR )
%DIVIDE Summary of this function goes here
%   Detailed explanation goes here

Q = length(mat);

[trI, valI, teI] = dividerand(Q, trR, valR, teR);

trS = mat(trI,:);
valS = mat(valI,:);
teS = mat(teI,:);

end

