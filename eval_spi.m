function eval_spi(method,iSub,iK)
% spatial discontiguity index
% 2016-3-20 15:57:32

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

load sSub.mat;
load sK.mat;

cSub=sSub(iSub);
cK=sK(iK);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK));
img_parc_new=parc_distinct(img_parc);
K_new=length(unique(img_parc_new))-1;
spi=K_new-K;
save(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK),'img_parc','K','spi');
