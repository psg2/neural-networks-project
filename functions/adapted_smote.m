function [ X_oversampled ] = adapted_smote( X, divisor, k, lim )
%SMOTEADAPTADO Summary of this function goes here
%   Detailed explanation goes here
[ r, c ] = size(X);

X_oversampled = [];
X_temp = X;
data = X(1:divisor,:);

for i=1:divisor
    temp = X_temp;
    temp(i,:) = [];
    [ idx, ~ ] = knnsearch(temp, data(i,:), 'k', k);
    newX = zeros(k, c);
    for j=1:k
        sigma = rand();
        if idx(j) > divisor
            sigma = sigma * 0.5;
        end;
        newX(j,:) = X_temp(idx(j),:) * sigma;
    end;
    
    X_oversampled = [ X_oversampled ; X_temp(i,:) ; newX ];
end;

X_oversampled = X_oversampled(1:lim,:);

end

