% Steps preparing for parcellation. 
% 2016-4-8 10:34:45

clear,clc;

%% deal with the demo data
% unzip
gunzip('pyClusterROI_testdata.1.0.tar.gz');
untar('pyClusterROI_testdata.1.0.tar');
gunzip('pyClusterROI/gm_maskfile.nii.gz','./');
for i=1:3
    gunzip(sprintf('pyClusterROI/subject%d.nii.gz',i),'./');
end

% delete
delete('pyClusterROI_testdata.1.0.tar');
rmdir('pyClusterROI/','s');

% rename
movefile('gm_maskfile.nii','graymatter.nii');
mkdir('data');
for i=1:3
    movefile(sprintf('subject%d.nii',i),sprintf('data/sub%05d.nii',i));
end

% change the nonzero elements in the graymatter mask from 32767 to 1
nii=load_untouch_nii('graymatter.nii');
img=nii.img;
img(img~=0)=1;
nii.img=img;
save_untouch_nii(nii,'graymatter.nii');

%% the sets
sSub=[1,2,3]; % the set of the subjects
nSub=length(sSub);
save('sSub.mat','sSub','nSub');

sK=[50:50:1000]; % the set of the cluster numbers
nK=length(sK);
save('sK.mat','sK','nK');

%% utilities
% create a searchlight of the 26-connected neighborhood
r=1;
shape='cube';
[riSL,nvSL]=parc_searchlight(r,shape);
save('parc_searchlight.mat','riSL','nvSL');

% the information of the graymatter
file_mask='graymatter.nii';
nii=load_untouch_nii(file_mask);
img_gray=double(nii.img);
msk_gray=img_gray~=0;
ind_gray=find(msk_gray);
num_gray=length(ind_gray);
siz=size(msk_gray);
save('parc_graymatter.mat','msk_gray','ind_gray','num_gray','siz');

% the coordinates of the adjacent voxels
parc_cavb;

%% normalize each time course to be zero mean and unit length
mkdir('prep');
parc_parpool(nSub);
parfor iSub=1:nSub
    parc_preprocess(iSub);
end