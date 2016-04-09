function tmp=parc_norm(tmp)
% Normalize each row of a matrix to be zero mean and unit length. After 
% this, we could calculate the Pearson's correlation coefficient by matrix
% multiplication. 
% 2015-6-3 08:42:58

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

n=size(tmp,2);
tmp=tmp-repmat(mean(tmp,2),[1,n]); % demean
tmp=tmp./repmat(sqrt(sum(tmp.^2,2)),[1,n]); % normalize to unit length