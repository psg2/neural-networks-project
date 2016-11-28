function [ result ] = underSampleKMeans( mat, k )
%UNDERSAMPLEKMEANS Summary of this function goes here
%   Detailed explanation goes here

[ X, Y ] = separeteClass(mat);

costGlobal = realmax;
finalClusters = [];

for i=1:100
    [ ~, C, SUMD ] = kmeans(X, k);
    if SUMD < costGlobal
        costGlobal = SUMD;
        finalClusters = C;
    end;
end;

result = [ finalClusters Y(1:k) ];

end

