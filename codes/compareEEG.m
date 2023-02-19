clear

%% Read Graphs

G1 = load("10SimWindow_01.mat").G1;
G2 = load("10SimWindow_01.mat").G2;
G3 = load("10SimWindow_01.mat").G3;
G4 = load("10SimWindow_01.mat").G4;
G5 = load("10SimWindow_01.mat").G5;

%% Degree distribution

D1 = sum(G1,1);
D2 = sum(G2,1);
D3 = sum(G3,1);
D4 = sum(G4,1);
D5 = sum(G5,1);

figure()
hold on
plot(D1,LineWidth=1.5);
plot(D2,LineWidth=1.5);
plot(D3,LineWidth=1.5);
plot(D4,LineWidth=1.5);
plot(D5,LineWidth=1.5);
hold off
xlabel('k')
ylabel('deg(k)')
title('Degree vs Node Index')
legend('Pre Seizure - I', 'Pre Seizure - II', 'Seizure', 'Post Seizure - II', 'Post Serizure - I');

figure()
subplot(5,1,1)
histogram(D1,5);
xlim([0,8])
title('Degree distribution (G1)')
subplot(5,1,2)
histogram(D2,5);
xlim([0,8])
title('Degree distribution (G2)')
subplot(5,1,3)
histogram(D3,5);
xlim([0,8])
title('Degree distribution (G3)')
subplot(5,1,4)
histogram(D4,5);
xlim([0,8])
title('Degree distribution (G4)')
subplot(5,1,5)
histogram(D5,5);
xlim([0,8])
title('Degree distribution (G5)')

%% Clustering coefficients

CC1 = clust_coeff(G1);
CC2 = clust_coeff(G2);
CC3 = clust_coeff(G3);
CC4 = clust_coeff(G4);
CC5 = clust_coeff(G5);

X = categorical({'Pre Seizure - I','Pre Seizure - II','Seizure','Post Seizure - II', 'Post Seizure - I'});
X = reordercats(X,{'Pre Seizure - I','Pre Seizure - II','Seizure','Post Seizure - II', 'Post Seizure - I'});
Y = [CC1,CC2,CC3,CC4,CC5];

figure()
bar(X,Y,'r')
title('Clustering Coefficients')