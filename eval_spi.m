% spatial discontiguity index
% 2016-3-20 15:57:32

function eval_spi(method,iSub,iK)

load sSub.mat;
load sK.mat;

cSub=sSub(iSub);
cK=sK(iK);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK));
img_parc_new=parc_distinct(img_parc);
K_new=length(unique(img_parc_new))-1;
spi=K_new-K;
save(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK),'img_parc','K','spi');
