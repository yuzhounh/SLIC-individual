function SLIC_sub_parc(iSub,iK)
% Perform individual subject level parcellation by SLIC. 
% 2016-4-8 16:05:41 

tic;
load sK.mat;
load sSub.mat;
load parc_graymatter.mat;

cK=sK(iK);
cSub=sSub(iSub);

load(sprintf('prep/sub%05d.mat',cSub)); 

m=40; % the tuning parameter
label=SLIC(img_gray,m,cK);
tmp=zeros(siz);
tmp(msk_gray)=label;
img_parc=tmp;
K=length(unique(label)); % actual cluster number

% save to .mat file
time=toc/3600;
save(sprintf('SLIC_sub_parc/sub%05d_K%d.mat',cSub,cK),'img_parc','K','time');
fprintf('Time to do parcellation: %0.2f hours. \n',time);

% save to .nii file
file_mask='graymatter.nii';
file_out=sprintf('SLIC_sub_parc/sub%05d_K%d.nii',cSub,cK);
parc_nii(file_mask,file_out,img_parc);