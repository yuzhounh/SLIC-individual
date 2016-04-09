% A potential way to choose the parameter m in SLIC. But it may not be the
% optimal way. 
% 2016-4-8 16:54:36

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