clc
clear

addpath('functions');

load results_final_updated

limiters = zeros(6,1);

dataset = { 'dataset_kmeans', 'dataset_smote', 'dataset_adapted_smote' };
learning_rate = [ 0.01, 0.03, 0.1, 0.4 ];
hidden_neuron = [ 3, 15, 50 ];
max_epoch = [ 1000, 3000, 9000 ];
algorithm = { 'traingd' ; 'trainrp' ; 'trainoss' ; 'trainlm' };
transfer_function = { 'tansig', 'elliotsig' };
params.max_fail = 6;

combs = [ 1 13 28 ; 1 13 25 ; 1 96 25 ];

combinations_kmeans = combinations(combinations(:,1)==1,:);
combinations_smote = combinations(combinations(:,1)==2,:);
combinations_adapted_smote = combinations(combinations(:,1)==3,:);

performances_kmeans = performances(combinations(:,1)==1,:);
performances_smote = performances(combinations(:,1)==2,:);
performances_adapted_smote = performances(combinations(:,1)==3,:);

[ ~, sort_kmeans ] = sort(cell2mat(performances_kmeans(:,1)), 'descend');
[ ~, sort_smote ] = sort(cell2mat(performances_smote(:,1)), 'descend');
[ ~, sort_adapted_smote ] = sort(cell2mat(performances_adapted_smote(:,1)), 'descend');

performances_kmeans = performances_kmeans(sort_kmeans,:);
performances_smote = performances_smote(sort_smote,:);
performances_adapted_smote = performances_adapted_smote(sort_adapted_smote,:);

combinations_kmeans = combinations_kmeans(sort_kmeans,:);
combinations_smote = combinations_smote(sort_smote,:);
combinations_adapted_smote = combinations_adapted_smote(sort_adapted_smote,:);

num_datasets = 3;
num_combs = 3;
num_tests = 30;
idx = 1;

performances_datasets = cell(num_datasets,1);
performances_datasets{1} = performances_kmeans;
performances_datasets{2} = performances_smote;
performances_datasets{3} = performances_adapted_smote;

performances_final = zeros(9,4);
combinations_final = zeros(9,6);
perfs_final = cell(3, 3);

for i=1:num_datasets
    
    params.X = inputs{i, 1};
    params.T = inputs{i, 2};
    params.tr_ind = inputs{i, 3};
    params.val_ind = inputs{i, 4};
    params.te_ind = inputs{i, 5};
    
    for j=1:num_combs
        comb = combinations_kmeans(combs(i,j),:);
        p1 = i;
        p2 = comb(2);
        p3 = comb(3);
        p4 = comb(4);
        p5 = comb(5);
        p6 = comb(6);
        
        params.learning_rate = learning_rate(p2);
        params.hidden_neuron = hidden_neuron(p3);
        params.max_epoch = max_epoch(p4);
        params.algorithm = algorithm{p5};
        params.transfer_function = transfer_function{p6};
        
        fprintf('idx %d\n', idx);
        perfs = cell(num_tests,6);
        
        rng('default');
        
        for k=1:num_tests
            fprintf('%d - %d\n', idx, k);
            perfs(k,:) = train_mlp(params);
        end;
        perfs_final{i,j} = perfs;
        performances_final(idx,:) = mean(cell2mat(perfs(:,1:4)));
        combinations_final(idx,:) = [ p1 p2 p3 p4 p5 p6 ];
        idx = idx + 1;
    end;
end;

idx = 1;

performances_median = zeros(9,4);

for i=1:3
    for j=1:3
        perfs = perfs_final{i,j};
        performances_median(idx,:) = median(cell2mat(perfs(:,1:4)));
        idx = idx + 1;
    end;
end;

idx = 1;
performances_std = zeros(9,4);

for i=1:3
    for j=1:3
        perfs = perfs_final{i,j};
        performances_std(idx,:) = std(cell2mat(perfs(:,1:4)));
        idx = idx + 1;
    end;
end;

directory = { 'results2/KMEANS/', 'results2/SMOTE/', 'results2/SMOTE_ADAPTADO/' };

for i=1:3
    for j=1:3
        perfs = perfs_final{i,j};
        temp = cell2mat(perfs(:,1));
        [ ~, idx ] = sort(temp, 'descend');
        perfs = perfs(idx,:);
        for k=1:30
            y = perfs{k,5};
            te = perfs{k,6};
            figure = plotroc(te, y);
            print([ directory{i} 'roc-' num2str(i) '-' num2str(j) '-' num2str(k) ],'-dpng');
            figure = plotconfusion(te,y);
            print([ directory{i} 'confusion-' num2str(i) '-' num2str(j) '-' num2str(k) ],'-dpng');
            delete(findall(0, 'Type', 'figure'))
        end;
    end;
end;
