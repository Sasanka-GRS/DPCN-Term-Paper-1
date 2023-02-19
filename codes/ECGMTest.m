clear

%% Read Graphs

graphs_data = load("303SimWindow_8s.mat").Graphs_W;
layout = load("303SimWindow_8s.mat").Graphs_Layout;

%% Declare Variables

L = size(graphs_data);
N = L(1);
T = L(3);

eta = 0.5;
gamma = 0.5;

%% Generate new graphs

graphs_reg = zeros(N,N,T);
graphs_ran = zeros(N,N,T);
graphs_SW = zeros(N,N,T);
graphs_SF = zeros(N,N,T);

[graphs_reg1, graphs_ran1, graphs_SW1, graphs_SF1] = generateGraphs(N);

for k=1:T
    graphs_reg(:,:,k) = graphs_reg1;
    graphs_ran(:,:,k) = graphs_ran1;
    graphs_SW(:,:,k) = graphs_SW1;
    graphs_SF(:,:,k) = graphs_SF1;
end

%% Metrics for original graph

[CC_data, EFF_data, MOD_data] = allDistanceMetrics(graphs_data,layout,eta,gamma);


%% Metrics for regular graph

[CC_reg, EFF_reg, MOD_reg] = allDistanceMetrics(graphs_reg,layout,eta,gamma);

%% Metrics for random graph

[CC_ran, EFF_ran, MOD_ran] = allDistanceMetrics(graphs_ran,layout,eta,gamma);

%% Metrics for SW graph

[CC_SW, EFF_SW, MOD_SW] = allDistanceMetrics(graphs_SW,layout,eta,gamma);

%% Metrics for SF graph

[CC_SF, EFF_SF, MOD_SF] = allDistanceMetrics(graphs_SF,layout,eta,gamma);

%% Compiling

CC = [CC_data,CC_reg,CC_ran,CC_SW,CC_SF];
EFF = [EFF_data,EFF_reg,EFF_ran,EFF_SW,EFF_SF];
MOD = [MOD_data,MOD_reg,MOD_ran,MOD_SW,MOD_SF];

save('303Matrix.mat',"CC","EFF","MOD");