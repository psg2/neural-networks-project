function [ oversampledX ] = smoteAdaptado( X, len, k, class )
%SMOTEADAPTADO Summary of this function goes here
%   Detailed explanation goes here
[ r, c ] = size(X);

labels = X(:,c);

oversampledX = [];
tempX = X(:,1:c-1);
data = X(1:len,1:c-1);

for i=1:len
    temp = tempX;
    temp(i,:) = [];
    [ idx, ~ ] = knnsearch(temp, data(i,:), 'k', k);
    newX = zeros(k, c-1);
    for j=1:k
        sigma = 0.5 * rand();
        newX(j,:) = tempX(idx(j),:) * sigma;
    end;
    
    oversampledX = [ oversampledX ; tempX(i,:) ; newX ];
end;

oversampledX(:,c) = X(1,c);

end

