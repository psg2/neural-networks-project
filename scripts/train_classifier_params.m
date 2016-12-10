clc
clear

addpath('data');
addpath('functions');

limiters = zeros(6,1);

dataset = { 'dataset_kmeans', 'dataset_smote', 'dataset_adapted_smote' };
learning_rate = [ 0.01, 0.03, 0.1, 0.4 ];
hidden_neuron = [ 3, 15, 50 ];
max_epoch = [ 1000, 3000, 9000 ];
algorithm = { 'traingd' ; 'trainrp' ; 'trainoss' ; 'trainlm' };
transfer_function = { 'tansig', 'elliotsig' };

limiters(1) = length(dataset);
limiters(2) = length(learning_rate);
limiters(3) = length(hidden_neuron);
limiters(4) = length(max_epoch);
limiters(5) = length(algorithm);
limiters(6) = length(transfer_function);

number_combinations = prod(limiters);
number_parameters = 6;
number_measurements = 5;

combinations = zeros(number_combinations, number_parameters);
performances = cell(number_combinations, number_measurements);

idx = 1;

for p1=1:limiters(1);
    load(dataset{p1});
    
    [ X, T, tr_ind, val_ind, te_ind ] = prepare_data(class0, class1);
    
    params.X = X;
    params.T = T;
    params.tr_ind = tr_ind;
    params.val_ind = val_ind;
    params.te_ind = te_ind;
    
    for p2=1:limiters(2);
        for p3=1:limiters(3);
            for p4=1:limiters(4);
                for p5=1:limiters(5);
                    for p6=1:limiters(6);
                        params.learning_rate = learning_rate(p2);
                        params.hidden_neuron = hidden_neuron(p3);
                        params.max_epoch = max_epoch(p4);
                        params.algorithm = algorithm{p5};
                        params.transfer_function = transfer_function{p6};
                        
                        fprintf('%d\n', idx);
                        rng('default');
                        
                        performances(idx,:) = train_mlp(params);

                        combinations(idx,:) = [ p1 p2 p3 p4 p5 p6 ];
                        idx = idx + 1;
                    end;
                end;
            end;
        end;
    end;
end;