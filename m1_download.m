% Download the NIFTI toolbox and Craddock's demo data from the web. You
% might do this manually from the links:
%     http://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image
%     https://www.nitrc.org/projects/cluster_roi/
% If so, unzip the NIFTI toolbox and add it to the Matlab search path, put
% the .tar.gz demo data in the same folder as the scripts.
% 2016-4-8 15:36:40

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

% NIFTI toolbox, 0.42 MB
url='http://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/8797/versions/28/download/zip/NIfTI_20140122.zip';
filename='NIfTI_20140122.zip';
if ~exist(filename,'file')
    urlwrite(url,filename);
end

% demo data, 30.21 MB
% From https://www.nitrc.org/projects/cluster_roi/
url='ftp://www.nitrc.org/home/groups/cluster_roi/htdocs/pyClusterROI/pyClusterROI_testdata.1.0.tar.gz';
filename='pyClusterROI_testdata.1.0.tar.gz';
if ~exist(filename,'file')
    fprintf('Begin downloading the data (30.21 MB). Please wait......\n');
    urlwrite(url,filename);
    fprintf('Completed.\n');
end
