function [ Xnorm ] = normalizeData( X )
%NORMALIZEDATA Summary of this function goes here
%   Detailed explanation goes here

[ r, c ] = size(X);
Xnorm = X;

for i=1:c-1
    temp = X(:,i);
    Xnorm(:,i) = 2 .* ( temp - min(temp) ) ./ ( max(temp) - min(temp) ) - 1;
end;

end

