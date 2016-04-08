% A potential way to choose the parameter m in SLIC. But it may not be the
% optimal way. 
% 2016-4-8 16:54:36

clear,clc;

load sSub.mat;
load sK.mat;

tmp=zeros(nSub,nK);
tic;
for iSub=1:nSub
    cSub=sSub(iSub);
    for iK=1:nK
        cK=sK(iK);
        load(sprintf('SLIC_sub_parc/sub%05d_K%d.mat',cSub,cK),'para');
        para(isinf(para))=[];
        tmp(iSub,iK)=(mean(para)+median(para))/2; % between mean and median
    end
    perct(toc,iSub,nSub);
end

% The results are 0.67~0.87 for Craddock's data. But I find that 40 is
% better. 