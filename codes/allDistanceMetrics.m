function [CC, EFF, MOD] = allDistanceMetrics(graphs, lay, eta, gamma)
    
%% Declare Variables

L = size(graphs);
N = L(1);
T = L(3);

%% Data based graph metrics

layout = lay;

[~, CC_data, EFF_data, MOD_data] = economicalClusteringGenerativeModel(graphs,layout,eta,gamma);

%% Regular based graph metrics

for k=1:T
    layout(:,:,k) = [(1:N)',(1:N)'];
end

[~, CC_re, EFF_re, MOD_re] = economicalClusteringGenerativeModel(graphs,layout,eta,gamma);

%% Random based graph metrics

layout = rand(N,N,T);
[~, CC_ra, EFF_ra, MOD_ra] = economicalClusteringGenerativeModel(graphs,layout,eta,gamma);

%% Compile

CC = [CC_data;CC_re;CC_ra];
EFF = [EFF_data;EFF_re;EFF_ra];
MOD = [MOD_data;MOD_ra;MOD_re];

end