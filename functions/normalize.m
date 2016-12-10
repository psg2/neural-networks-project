function [ X_norm ] = normalize( X )
%NORMALIZEDATA Summary of this function goes here
%   Detailed explanation goes here

[ ~, c ] = size(X);
X_norm = X;

for i=1:c
    temp = X(:,i);
    X_norm(:,i) = 2 .* ( temp - min(temp) ) ./ ( max(temp) - min(temp) ) - 1;
end;

end

