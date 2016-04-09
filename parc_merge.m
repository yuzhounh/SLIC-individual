function img_parc=parc_merge(img_parc)
% Merge the clusters with only one voxel to its nearest neighbors.
% 2015-4-30 08:58:34

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

load('parc_graymatter.mat');
load('parc_searchlight.mat');

temp=tabulate(img_parc(:));
ind=temp(:,2)==1;
sLabel=temp(ind,1);
nLabel=length(sLabel);
for iLabel=1:nLabel
    cLabel=sLabel(iLabel);
    
    % find the clusters with only one voxel
    temp=img_parc==cLabel;
    
    % single index
    ind=find(temp);
    
    % coordinates in the 3D space
    [i,j,k]=ind2sub(siz,ind);
    
    % searchlight constraint
    ix=riSL+repmat([i,j,k],nvSL,1);
    
    % single index
    index=sub2ind(siz,ix(:,1),ix(:,2),ix(:,3));
    
    label_neighbors=img_parc(index);
    tmp=tabulate(label_neighbors);
    [~,ix]=sort(tmp(:,2));
    tmp=tmp(ix,:);
    
    if tmp(1)~=0
        img_parc(ind)=tmp(1);
    else
        img_parc(ind)=tmp(2);
    end
end