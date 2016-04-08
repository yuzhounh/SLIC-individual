% The coordinates of the adjacent voxels. This is determined by the
% graymatter mask and the searchlight. 
% 2016-4-8 11:23:47

% clear,clc;

load('parc_graymatter.mat');
load('parc_searchlight.mat');

nM=num_gray;

% adjacency matrix
fprintf('Calculating the coordinates of the adjacent voxels.\n');
cav=zeros(nM,nvSL);
tic;
for iM=1:nM
    % subscript of a single index in graymatter
    [i,j,k]=ind2sub(siz,ind_gray(iM));
    
    % searchlight constraint
    ix=riSL+repmat([i,j,k],nvSL,1);
    
    % box constraint
    tmp=all(ix>=ones(nvSL,3),2) & all(ix<=repmat(siz,nvSL,1),2);
    ix=ix(tmp,:);
    
    % single index
    % for voxels within the union of the searchlight and the box
    index=sub2ind(siz,ix(:,1),ix(:,2),ix(:,3));
    
    % mask constraint
    % convert the index in 3D space to that in the mask
    [tmp,index]=ismember(index,ind_gray);
    index=index(tmp);
    ix=ix(tmp,:);
    
    % save the coordinates of the adjacent voxels, cav
    cav(iM,1:length(index))=index';
    
    perct(toc,iM,nM,20);
end

% the binary format of cav
fprintf('Calculating the binary format of CAV.\n');
n=size(cav,1);
cavb=sparse(n,n);
tic;
for i=1:n
    tmp=cav(i,:);
    tmp(tmp==0)=[];
    cavb(i,tmp)=1;
    perct(toc,i,n,20);
end

save('parc_cavb.mat','cav','cavb');