function [riSL,nvSL]=parc_searchlight(r,shape)
% Construct a searchlight.
% Input:
%     r, radius
%     shape, cube or shpere
% Output:
%     riSL, relative indices of the voxels in the searchlight
%     nvSL, number of voxles in the searchlight
% 2014-10-17 19:59:55

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

fr=floor(r);
riSL=zeros((2*fr+1)^3,3);

count=0; 
if strcmp(shape,'cube')
    for i=-fr:fr
        for j=-fr:fr
            for k=-fr:fr
                count=count+1;
                riSL(count,:)=[i,j,k];
            end
        end
    end
elseif strcmp(shape,'sphere')
    for i=-fr:fr
        for j=-fr:fr
            for k=-fr:fr
                if i^2+j^2+k^2<=r^2
                    count=count+1;
                    riSL(count,:)=[i,j,k];
                end
            end
        end
    end
else
    error('Please check the shape.');
end
riSL=riSL(1:count,:);
nvSL=count;