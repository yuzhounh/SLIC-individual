function eval_homogeneity(method,iS,iK)
% homogeneity
% 2015-9-2 09:52:55

tic;

load parc_graymatter.mat;
nM=num_gray;

load sK.mat;
cK=sK(iK);

load sSub.mat;
nSub=length(sSub);
cS=sSub(iS);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cS,cK));
img_parc=img_parc(msk_gray);
sC=unique(img_parc); % the label set of the clusters, should be [1:cK]
nC=length(sC);

homogeneity=zeros(nSub,1);
for iSub=1:nSub
    cSub=sSub(iSub);
    load(sprintf('prep/sub%05d.mat',cSub));
    
    % within cluster similarity
    a=zeros(nC,1);
    for iC=1:nC
        cC=sC(iC); % current cluster
        ix=find(img_parc==cC);
        nV=length(ix); % number of voxels in this cluster
        if nV~=1
            tmp=img_gray(ix,:)*img_gray(ix,:)';
            tmp=tmp-diag(diag(tmp)); % clear the diagonals
            tmp=sum(tmp(:))/(nV^2-nV); % don't count the diagonals
            a(iC)=tmp;
        end
    end
    a(a==0)=[]; % clear zeros
    homogeneity(iSub,1)=mean(a);
end
homogeneity(iS)=[];
homogeneity=mean(homogeneity);

time=toc/3600;
fprintf('Time to calculate homogeneity: %0.2f hours. \n',time);
save(sprintf('%s_sub_homogeneity/sub%05d_K%d.mat',method,cS,cK),'homogeneity','time');