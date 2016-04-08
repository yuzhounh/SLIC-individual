function tmp=parc_norm(tmp)
% Normalize each row of a matrix to be zero mean and unit length. After 
% this, we could calculate the Pearson's correlation coefficient by matrix
% multiplication. 
% 2015-6-3 08:42:58

n=size(tmp,2);
tmp=tmp-repmat(mean(tmp,2),[1,n]); % demean
tmp=tmp./repmat(sqrt(sum(tmp.^2,2)),[1,n]); % normalize to unit length