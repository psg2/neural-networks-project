function [ X_oversampled ] = smote( X, k, lim, num_examples );
%SMOTE Summary of this function goes here
%   Detailed explanation goes here

[ r, c ] = size(X);

X_oversampled = [];
X_temp = X;

for i=1:r
    temp = X_temp;
    temp(i,:) = [];
    [ idx, ~ ] = knnsearch(temp, X_temp(i,:), 'k', k);
    X_new = zeros(num_examples, c);
    for j=1:num_examples
        neighbour = temp(idx(randi(k)),:);
        sigma = rand();
        X_new(j,:) = X_temp(i,:) + ( neighbour - X_temp(i,:) ) * sigma;
    end;
    X_oversampled = [ X_oversampled ; X_temp(i,:) ; X_new ];
end;

X_oversampled = unique(X_oversampled, 'rows');

X_oversampled = X_oversampled(1:lim,:);

end

