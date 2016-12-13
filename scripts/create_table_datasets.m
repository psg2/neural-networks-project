clc
clear

addpath('functions');

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

table_kmeans = create_table(combinations_kmeans, performances_kmeans);
table_smote = create_table(combinations_smote, performances_smote);
table_adapted_smote = create_table(combinations_adapted_smote, performances_adapted_smote);

writetable(table_kmeans, 'table_kmeans.xls');
writetable(table_smote, 'table_smote.xls');
writetable(table_adapted_smote, 'table_adapted_smote.xls');