clc
clear

load results_final_updated

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

performances_datasets = cell(num_datasets,1);
performances_datasets{1} = performances_kmeans;
performances_datasets{2} = performances_smote;
performances_datasets{3} = performances_adapted_smote;

directory = { 'results/KMEANS/', 'results/SMOTE/', 'results/SMOTE_ADAPTADO/' };

for i=1:num_datasets
    fprintf('Dataset nº: %d\n', i);
    dataset = performances_datasets{i};
    num_combinations = length(dataset);
    
    for j=20:num_combinations
        measures = cell2mat(dataset(j,1:4));
        fprintf('Combination nº: %d\n', j);
        fprintf('%.3f %.3f %.3f %.3f', measures);
        fprintf('\n');
        y = dataset{j,5};
        te = dataset{j,6}; 

        figure = plotroc(te, y);
        print([ directory{i} 'roc-' num2str(i) '-' num2str(j) ],'-dpng');
        figure = plotconfusion(te,y);
        print([ directory{i} 'confusion-' num2str(i) '-' num2str(j) ],'-dpng');
        delete(findall(0, 'Type', 'figure'))
        %         [ ~, ~, ~, AUC ] = perfcurve(te, y, 1);
    end;
end;