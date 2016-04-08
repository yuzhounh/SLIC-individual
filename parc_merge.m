function img_parc=parc_merge(img_parc)
% Merge the clusters with only one voxel to its nearest neighbors.
% 2015-4-30 08:58:34

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