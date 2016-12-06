function [ class1, class2 ] = divideClass( mat )
%DIVIDECLASS Summary of this function goes here
%   Detailed explanation goes here

classColumn = mat(:,end);

class1 = mat(classColumn==1,:);
class2 = mat(classColumn==0,:);

end

