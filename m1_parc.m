% Parcellation. The number of parallel workers should be set carefully 
% according to the number of tasks and CPUs. 
% 2016-3-22 18:49:35

clear,clc;

mkdir('sub_weight');
mkdir('sub_eigen');
mkdir('Ncut_sub_parc');
mkdir('SLIC_sub_parc');

load sSub.mat;
load sK.mat;

parc_parpool(3);
parfor iSub=1:nSub
    sub_weight(iSub);
    sub_eigen(iSub);
end

% % sub_parc
stat=[];
for iSub=1:nSub
    cSub=sSub(iSub);
    for iK=1:nK
        cK=sK(iK);
        if ~exist(sprintf('SLIC_sub_parc/sub%05d_K%d.mat',cSub,cK));
            stat=[stat;iSub,iK];
        end
    end
end
n=size(stat,1);
fprintf('The number of tasks: %d. \n\n',n);
parc_parpool(3);
parfor i=1:n
    iSub=stat(i,1);
    iK=stat(i,2);
    Ncut_sub_parc(iSub,iK);
    SLIC_sub_parc(iSub,iK);
end
