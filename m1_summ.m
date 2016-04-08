% Summarize the evaluation results.
% 2016-3-24 20:05:46

load Ncut_eval.mat;
num_Ncut_MSC=num;
spi_Ncut_MSC=spi;
hom_Ncut_MSC=hom;
dic_Ncut_MSC=dic;

load SLIC_eval.mat;
num_Ncut_SLIC=num;
spi_Ncut_SLIC=spi;
hom_Ncut_SLIC=hom;
dic_Ncut_SLIC=dic;

num=[mean(num_Ncut_MSC,1); mean(num_Ncut_SLIC,1)];
spi=[mean(spi_Ncut_MSC,1); mean(spi_Ncut_SLIC,1)];
hom=[mean(hom_Ncut_MSC,1); mean(hom_Ncut_SLIC,1)];
dic=[mean(dic_Ncut_MSC,1); mean(dic_Ncut_SLIC,1)];

save('m1_summ.mat','num','spi','hom','dic');