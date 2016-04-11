function sub_eigen(iSub)
% Apply Ncut on the weight matrix to extract features/eigenvectors. The 
% eigenvectors obtained would be input into clustering algorithms to do 
% parcellation. 
% 2016-4-8 16:01:58 

%     Parcellating whole brain for individuals by simple linear iterative clustering
%     Copyright (C) 2016 Jing Wang
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

tic;

load sSub.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('sub_weight/sub%05d.mat',cSub)); % weight matrix

K0=1000; % calculate at most 1000 nontrivial eigenvectors
delta=200; % for redundancy, and should set larger in case of error
[EV,EDD]=Ncut_eigen(W,K0+nEmpty+delta); % nEmpty is for redundancy also
nTrivial=sum(EDD<1e-4);  % the number of trivial eigenvalues
EV=EV(:,end-nTrivial-K0+1:end-nTrivial);  % noly keep the nontrivial values and eigenvectors
EDD=EDD(end-nTrivial-K0+1:end-nTrivial);

time=toc/3600;
save(sprintf('sub_eigen/sub%05d.mat',cSub),'EV','EDD','nTrivial','time');
fprintf('Time to calculate eigenvectors: %0.2f hours. \n\n',time);
