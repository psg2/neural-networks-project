function [ X_oversampled ] = adapted_smote( X, divisor, k, lim, num_examples )
%SMOTEADAPTADO Summary of this function goes here
%   Detailed explanation goes here
[ r, c ] = size(X);

X_oversampled = [];
X_temp = X;

for i=1:divisor
    temp = X_temp;
    temp(i,:) = [];
    [ idx, ~ ] = knnsearch(temp, X(i,:), 'k', k);
    X_new = zeros(num_examples, c);
    for j=1:num_examples
        pos = idx(randi(k));
        neighbour = temp(pos,:);
        sigma = rand();
        if pos > divisor
            sigma = sigma * 0.5;
        end;
        X_new(j,:) = X_temp(i,:) + ( neighbour - X_temp(i,:) ) * sigma;
    end;
    
    X_oversampled = [ X_oversampled ; X_temp(i,:) ; X_new ];
end;

X_oversampled = unique(X_oversampled, 'rows');

X_oversampled = X_oversampled(1:lim,:);

end

