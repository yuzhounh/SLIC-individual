% Steps preparing for parcellation. 
% 2016-4-8 10:34:45

%     Parcellating whole brain for individuals by simple linear iterative clustering
%     Copyright (C) 2016 Jing Wang
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

clear,clc;

%% add the NIfTI toolbox into the path
unzip('NIfTI_20140122.zip','NIfTI/'); % unzip
addpath('NIfTI/'); % add path

%% the sets
sSub=[0440,1018,1244]; % the set of the subjects
nSub=length(sSub);
save('sSub.mat','sSub','nSub');

sK=[50:50:1000]; % the set of the cluster numbers
nK=length(sK);
save('sK.mat','sK','nK');

%% demo data
unzip('SLIC_individual_data.zip');
gunzip('*.gz');
delete('*.gz');
mkdir('data');
for iSub=1:nSub
    cSub=sSub(iSub);
    movefile(sprintf('sub%05d.nii',cSub),sprintf('data/sub%05d.nii',cSub));
end

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
