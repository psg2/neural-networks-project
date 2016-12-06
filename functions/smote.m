function [ oversampledX ] = smote( X, k );
%SMOTE Summary of this function goes here
%   Detailed explanation goes here

[ r, c ] = size(X);

oversampledX = [];
tempX = X(:,1:c-1);

for i=1:r
    sigma = rand(k, 1);
    temp = tempX;
    temp(i,:) = [];
    [ idx, ~ ] = knnsearch(temp, tempX(i,:), 'k', k);
    newX = zeros(k, c-1);
    for j=1:k
        newX(j,:) = tempX(idx(j),:) * sigma(j);
    end;
    
    oversampledX = [ oversampledX ; tempX(i,:) ; newX ];
end;

oversampledX(:,c) = X(1,c);

end

