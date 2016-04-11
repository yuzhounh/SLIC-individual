function sub_weight(iSub)
% the individual subject level weight matrix with spatial constraint and a 
% hard threshold
% 2016-4-8 16:00:17

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
load parc_cavb.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('prep/sub%05d.mat',cSub));

% weight matrix
nM=num_gray;
W=sparse(nM,nM);
for iM=1:nM
    sV=cav(iM,:); % set of voxels in cav
    sV(sV==0)=[]; % delete zeros
    if ~isempty(sV)
        nV=length(sV); 
        for iV=1:nV
            iN=sV(iV);
            if iM<iN % symmetric property
                tmp=img_gray(iM,:)*img_gray(iN,:)'; % Pearson's correlation
                W(iM,iN)=tmp*(tmp>=0.5); % exclude negative and weak correlations
            end
        end
    end
    perct(toc,iM,nM,10);
end
W=W+W'; % symmetric property
[W,nEmpty]=parc_diag(W); % for empty rows, set the diagonal elements to be ones

time=toc/3600;
save(sprintf('sub_weight/sub%05d.mat',cSub),'W','nEmpty','time');
fprintf('Time to construct weight matrix: %0.2f hours. \n',time);
