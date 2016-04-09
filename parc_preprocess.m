function parc_preprocess(iSub)
% Preprocess the resting state fMRI data. Clear (set to zeros) the time 
% courses with zero standard variation. For others, demean each time course
% and then normalize it to unit length. After these operations, Pearson's
% correlation could be calculated by Euclidean distance or matrix
% multiplication, which will save a lot of time. 
% 2014-10-17 19:01:25

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
cSub=sSub(iSub);

load parc_graymatter.mat;
N=prod(siz);

file_in=sprintf('data/sub%05d.nii',cSub);
file_out_nii=sprintf('prep/sub%05d.nii',cSub);
file_out_mat=sprintf('prep/sub%05d.mat',cSub);

% resting state fMRI data
nii=load_untouch_nii(file_in);
img_rs=double(nii.img);
num_trial=size(img_rs,4); 
img_rs=reshape(img_rs,N,num_trial);  % image data
flag=zeros(N,1);
for i=1:N
    flag(i)=std(img_rs(i,:)); % 0 indicates empty time course
end
flag=flag~=0; 
msk_rs=reshape(flag,siz); % mask with nonempty time courses

% merged mask, within graymatter mask and not empty
msk_merge=msk_rs.*msk_gray; 
ind_merge=find(msk_merge==1);

% demean for each time course, then normalize it to unit length
tmp=img_rs(ind_merge,:); % only consider data within merged mask
tmp=tmp-repmat(mean(tmp,2),[1,num_trial]); % demean
tmp=tmp./repmat(sqrt(sum(tmp.^2,2)),[1,num_trial]); % normalize to unit length

% map preprocessed data on graymatter mask
[~,index]=ismember(ind_merge,ind_gray);
img_gray=zeros(num_gray,num_trial);
img_gray(index,:)=tmp;

% save to .nii file
img_4d=zeros([siz,num_trial]);
for i=1:length(ind_merge)
    [a,b,c]=ind2sub(siz,ind_merge(i));
    img_4d(a,b,c,:)=tmp(i,:);
end
nii.img=img_4d;
save_untouch_nii(nii,file_out_nii);

time=toc/3600; % hours
fprintf('Time to preprocess sub%05d: %0.2f hours. \n\n',cSub,time);
save(file_out_mat,'img_gray','ind_merge','time');