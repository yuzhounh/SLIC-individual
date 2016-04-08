function sub_weight(iSub)
% the individual subject level weight matrix with spatial constraint and a 
% hard threshold
% 2016-4-8 16:00:17

tic;

load sSub.mat;
load parc_cavb.mat;

cSub=sSub(iSub);
load(sprintf('prep/sub%05d.mat',cSub));

W=img_gray*img_gray'; % cross-correlation
W=W.*cavb; % spatial constraint
W=W.*(W>=0.5); % threshold 0.5
[W,nEmpty]=parc_diag(W); % for empty rows, set the diagonal elements to be ones

time=toc/3600;
save(sprintf('sub_weight/sub%05d.mat',cSub),'W','nEmpty','time');
fprintf('Time to construct weight matrix: %0.2f hours. \n',time);