% Four evaluation metrics: actual cluster number, spatial discontiguity
% index, functional homogeneity and Dice coefficient.
% 2015-9-2 09:34:12

clear,clc;

load sSub.mat;
load sK.mat;

for methods={'Ncut','SLIC'}
    method=methods{1,1};
    
    mkdir(sprintf('%s_sub_homogeneity',method));
    
    parc_parpool(3);
    parfor iK=1:nK
        for iSub=1:nSub
            eval_homogeneity(method,iSub,iK);
            eval_spi(method,iSub,iK);
        end
    end
    
    % actual cluster number
    tmp=zeros(nSub,nK);
    for iSub=1:nSub
        cSub=sSub(iSub);
        for iK=1:nK
            cK=sK(iK);
            load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK),'K');
            tmp(iSub,iK)=K;
        end
    end
    num=tmp;
    
    % spatial discontiguity index
    tmp=zeros(nSub,nK);
    for iSub=1:nSub
        cSub=sSub(iSub);
        for iK=1:nK
            cK=sK(iK);
            load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK),'spi');
            tmp(iSub,iK)=spi;
        end
    end
    spi=tmp;
    
    % homogeneity
    tmp=zeros(nSub,nK);
    for iSub=1:nSub
        cSub=sSub(iSub);
        for iK=1:nK
            cK=sK(iK);
            load(sprintf('%s_sub_homogeneity/sub%05d_K%d.mat',method,cSub,cK),'homogeneity');
            tmp(iSub,iK)=homogeneity;
        end
    end
    hom=tmp;
    
    % Dice
    tmp=[1,2;1,3;2,3];
    nRep=3;
    dice=zeros(nRep,nK);
    parc_parpool(3);
    parfor iK=1:nK
        for iRep=1:nRep
            dice(iRep,iK)=eval_dice(method,sSub(tmp(iRep,1)),sSub(tmp(iRep,2)),iK);
        end
    end
    dic=dice;
    
    save(sprintf('%s_eval.mat',method),'num','spi','hom','dic');
end
