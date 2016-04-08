% spatial discontiguity index
% 2016-3-20 15:57:32

function eval_spi(method,iSub,iK)

load sSub.mat;
load sK.mat;

cSub=sSub(iSub);
cK=sK(iK);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK));
K0=K;
img_parc=parc_distinct(img_parc);
K=length(unique(img_parc))-1;
spi=(K-K0);

if exist('para')
    save(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK),'img_parc','para','K','time','spi');
else
    save(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK),'img_parc','K','time','spi');
end