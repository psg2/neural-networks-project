function [ X_oversampled ] = smote( X, k, lim );
%SMOTE Summary of this function goes here
%   Detailed explanation goes here

[ r, c ] = size(X);

X_oversampled = [];
X_temp = X;

for i=1:r
    sigma = rand(k, 1);
    temp = X_temp;
    temp(i,:) = [];
    [ idx, ~ ] = knnsearch(temp, X_temp(i,:), 'k', k);
    X_new = zeros(k, c);
    for j=1:k
        X_new(j,:) = X_temp(idx(j),:) * sigma(j);
    end;
    X_oversampled = [ X_oversampled ; X_temp(i,:) ; X_new ];
end;

X_oversampled = X_oversampled(1:lim,:);

end

