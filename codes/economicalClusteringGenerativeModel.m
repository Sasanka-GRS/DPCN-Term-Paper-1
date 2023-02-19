function [newGraphs, CC, EFF, MOD] = economicalClusteringGenerativeModel(graphs,layout,eta,gamma)

%% Declare Variables

L = size(graphs);
N = L(1);
T = L(3);

%% Generate Probability Matrices

K = graphs;
D = graphs;
P = graphs;

for k=1:T
    for i=1:N
        iNodes = graphs(i,:,k);
        iNeigh = find(iNodes);
        iLoc = layout(i,:,k);

        for j=1:N
            jNodes = graphs(:,j,k);
            jNeigh = find(jNodes);
            jLoc = layout(j,:,k);

            common = intersect(iNeigh,jNeigh);
            K(i,j,k) = length(common);
            D(i,j,k) = norm(iLoc-jLoc,2);
        end
    end
end

for k=1:T
    for i=1:N
        for j=1:N
            if(i==j)
                P(i,j,k) = 0;
            else
                P(i,j,k) = (K(i,j,k)^gamma)/(D(i,j,k)^eta);
            end
        end
    end
end

terms = sum(P,1);
term = squeeze(terms);
scale = sum(term,1);

for k=1:T
    P(:,:,k) = P(:,:,k)/(scale(k));
end

for k = 1:T
    m = max(max(P(:,:,k)));
    if(m~=0)
        P(:,:,k) = P(:,:,k)/m;
    end
end

%% Get new adjacency

newGraphs = zeros(N,N,T);

for k=1:T
    for i=1:N
        for j=i+1:N
            p = rand(1);
            if(p<P(i,j,k))
                newGraphs(i,j,k) = 1;
                newGraphs(j,i,k) = 1;
            end
        end
    end
end

%% Compute attributes

CC = zeros(T,1);
EFF = zeros(T,1);
MOD = zeros(T,1);

for k=1:T
    CC(k) = clust_coeff(newGraphs(:,:,k));
    modules = newman_eigenvector_method(newGraphs(:,:,k));
    MOD(k) = modularity_metric(modules,newGraphs(:,:,k));
end

dist = zeros(N,N,T);

for k=1:T
    for i=1:N
        dist(i,:,k) = simple_dijkstra(newGraphs(:,:,k),i);
    end
end

for k=1:T
    for i=1:N
        for j=i+1:N
            EFF(k) = EFF(k) + (1/dist(i,j,k));
        end
    end
    EFF(k) = EFF(k)/(0.5*N*(N+1));
end


%% Average over time

newGraphs = sum(newGraphs,3)/T;
CC = sum(CC)/T;
EFF = sum(EFF)/T;
MOD = sum(MOD)/T;

end