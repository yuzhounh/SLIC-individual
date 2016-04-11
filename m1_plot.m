% Ncut vs. SLIC with different evaluation metrics. 
% 2016-3-23 08:58:44

clear,clc;

load sK.mat;
load m1_summ.mat;

figure;

% difference
subplot(2,2,1);
plot(sK,num(1,:)-sK,'-o',...
    sK,num(2,:)-sK,'-+',...
    'LineWidth',1.2,'MarkerSize',8);
hold on;
plot(sK,zeros(size(sK)),'-k','LineWidth',1.2);
legend('Ncut','SLIC','location','southwest');
xlabel('Initialized cluster number');
ylabel('Difference');

% spatial discontiguity index
subplot(2,2,2);
plot(num(1,:),spi(1,:),'-o',...
    num(2,:),spi(2,:),'-+',...
    'LineWidth',1.2,'MarkerSize',8);
legend('Ncut','SLIC','location','east');
xlabel('K');
ylabel('Spatial discontiguity index');

% homogeneity
subplot(2,2,3);
plot(num(1,:),hom(1,:),'-o',...
    num(2,:),hom(2,:),'-+',...
    'LineWidth',1.2,'MarkerSize',8);
legend('Ncut','SLIC','location','southeast');
xlabel('K');
ylabel('Homogeneity');

% dice
subplot(2,2,4);
plot(num(1,:),dic(1,:),'-o',...
    num(2,:),dic(2,:),'-+',...
    'LineWidth',1.2,'MarkerSize',8);
legend('Ncut','SLIC','location','northeast');
xlabel('K');
ylabel('Dice');

pos=get(gcf,'Position'); 
scale=0.6; 
set(gcf,'Position',[pos(1),pos(2),pos(3)/scale,pos(4)/scale]);