function SLIC_sub_parc(iSub,iK)
% Perform individual subject level parcellation by SLIC. 
% 2016-4-8 16:05:41 

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

tic;
load sSub.mat;
load sK.mat;
load parc_graymatter.mat;

cK=sK(iK);
cSub=sSub(iSub);

% load the original image data
nii=load_untouch_nii(sprintf('data/sub%05d.nii',cSub));
img_rs=double(nii.img);
num_trial=size(img_rs,4); 
img_rs=reshape(img_rs,prod(siz),num_trial);  % image data
img_gray=img_rs(ind_gray,:); % only consider data within the graymatter mask

% apply SLIC on the original image data
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