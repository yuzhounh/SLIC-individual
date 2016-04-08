function dice=eval_dice(method,sub1,sub2,iK)
% Dice
% 2015-9-2 10:15:24

tic;

load parc_graymatter.mat;
nM=num_gray;

load sK.mat;
cK=sK(iK);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,sub1,cK));
A=img_parc(msk_gray);
A=pdist(A);
A=A==0;
A=sparse(double(A));

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,sub2,cK));
B=img_parc(msk_gray);
B=pdist(B);
B=B==0;
B=sparse(double(B));

% union
C=A.*B;

% sum
SA=sum(A(:));
SB=sum(B(:));
SC=sum(C(:));

% Dice's coefficient
dice=(2*SC)/(SA+SB);