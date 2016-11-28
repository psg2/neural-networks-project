function [ attrs, class ] = separeteClass( mat )
%SEPARETECLASS Summary of this function goes here
%   Detailed explanation goes here

attrs = mat(:,1:end-1);
class = mat(:,end);

end

