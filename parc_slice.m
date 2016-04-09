function img_slice=parc_slice(img_bg,img_parc,index)
% draw a slice as color patches
% Inputs:
%     img_bg, image for the background
%     img_parc, image of the parcellation results
%     index, a vector whose length is 3. Two of the three elements are 0 
%         and the rest one could index the desired plane
%     img_slice, image of this slice
% 2014-7-30 09:38:18

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

ix=find(index~=0);
[a,b,c]=size(img_bg);

% take out the plane and reshape it to a 2D image
if ix==1
    img_bg=img_bg(index(1),:,:);
    img_parc=img_parc(index(1),:,:);
    
    img_bg=reshape(img_bg,b,c);
    img_parc=reshape(img_parc,b,c);
elseif ix==2
    img_bg=img_bg(:,index(2),:);
    img_parc=img_parc(:,index(2),:);
    
    img_bg=reshape(img_bg,a,c);
    img_parc=reshape(img_parc,a,c);
else
    img_bg=img_bg(:,:,index(3));
    img_parc=img_parc(:,:,index(3));
    
    img_bg=reshape(img_bg,a,b);
    img_parc=reshape(img_parc,a,b);
end

rng(1);
cmp=randi([0,255],[1000,1,3]);

img_slice=repmat(img_bg,[1,1,3]); % gray space to color space
sLabel=unique(img_parc);
nLabel=length(sLabel);
for iLabel=2:nLabel % overlay color patches for each cluster except label=0
    cLabel=sLabel(iLabel); % current label
    [A,B]=find(img_parc==cLabel);
    nVoxel=length(A); % number of voxels in this cluster
    for iVoxel=1:nVoxel
        img_slice(A(iVoxel),B(iVoxel),:)=cmp(cLabel,1,:);
    end
end