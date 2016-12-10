function [ result ] = undersampling_kmeans( X, k )
%UNDERSAMPLEKMEANS Summary of this function goes here
%   Detailed explanation goes here

global_cost = realmax;
result = [];

for i=1:100
    [ ~, C, SUMD ] = kmeans(X, k);
    if SUMD < global_cost
        global_cost = SUMD;
        result = C;
    end;
end;

end

