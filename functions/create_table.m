function [ table ] = create_table( combination, performance )
%CREATE_TABLE Summary of this function goes here
%   Detailed explanation goes here

limiters = zeros(5,1);
num_combinations = length(combination);

variables = cell(num_combinations, 9);

learning_rate = [ 0.01, 0.03, 0.1, 0.4 ];
hidden_neuron = [ 3, 15, 50 ];
max_epoch = [ 1000, 3000, 9000 ];
algorithm = { 'Gradient descent' ; 'Resilient' ; 'One-step secant' ; 'Levenberg-Marquardt' };
transfer_function = { 'Hyperbolic tangent sigmoid', 'Elliot symmetric sigmoid' };

limiters(1) = length(learning_rate);
limiters(2) = length(hidden_neuron);
limiters(3) = length(max_epoch);
limiters(4) = length(algorithm);
limiters(5) = length(transfer_function);

temp = combination(:,2);
for i=1:limiters(1)
    idx = temp==i;
    variables(idx,1) = {learning_rate(i)};
end;

temp = combination(:,3);
for i=1:limiters(2)
    idx = temp==i;
    variables(idx,2) = {hidden_neuron(i)};
end;

temp = combination(:,4);
for i=1:limiters(3)
    idx = temp==i;
    variables(idx,3) = {max_epoch(i)};
end;

temp = combination(:,5);
for i=1:limiters(4)
    idx = temp==i;
    variables(idx,4) = {algorithm(i)};
end;

temp = combination(:,6);
for i=1:limiters(5)
    idx = temp==i;
    variables(idx,5) = {transfer_function(i)};
end;

variables(:,6) = performance(:,1);
variables(:,7) = performance(:,2);
variables(:,8) = performance(:,3);
variables(:,9) = performance(:,4);

names = { 'Learning_Rate', 'Hidden_Neurons', 'Max_Epoch', ...
    'Algorithm', 'Function', 'AUC', 'MSE_Tr', ...
    'MSE_Val', 'MSE_Te' };

table = cell2table(variables, 'VariableNames', names);

end

