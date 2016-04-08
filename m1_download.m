% Download the NIFTI toolbox and Craddock's demo data from the web. You
% might do this manually from the links:
%     http://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image
%     https://www.nitrc.org/projects/cluster_roi/    
% If so, unzip the NIFTI toolbox and add it to the Matlab search path, put
% the .tar.gz demo data in the same folder as the scripts. 
% 2016-4-8 15:36:40

clear,clc;

% NIFTI toolbox, 0.42 MB
url='http://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/8797/versions/28/download/zip/NIfTI_20140122.zip';
filename='NIfTI_20140122.zip';
urlwrite(url,filename);
unzip('NIfTI_20140122.zip','NIfTI/'); % unzip
addpath('NIfTI/'); % add path

% demo data, 30.21 MB
% From https://www.nitrc.org/projects/cluster_roi/
url='ftp://www.nitrc.org/home/groups/cluster_roi/htdocs/pyClusterROI/pyClusterROI_testdata.1.0.tar.gz';
filename='pyClusterROI_testdata.1.0.tar.gz';
fprintf('Begin downloading the data (30.21 MB). Please wait......\n');
urlwrite(url,filename);
fprintf('Completed.\n');