function parc_parpool(poolsize)
% Start parpool in different cases for parallel computing. 
% 
% The poolsize is a positive integer whose upper limit is constrainted by 
% several factors. Check:
%   1) Running Code on Parallel Pools - MATLAB & Simulink - MathWorks China
%   http://t.cn/Rq5rP8P
%   2) Memory. Reduce the pool size in case of the out of memory problem. 
% 
% The function 'matlabpool' is replaced by 'parpool' in R2013b (8.2) and
% removed in R2016a (9.0). See:
% Release Notes for Parallel Computing Toolbox - MATLAB & Simulink - 
% MathWorks China http://t.cn/Rq5eJ6q
% MATLAB version - Wikipedia, the free encyclopedia http://t.cn/Rq5gI7R
% 
% This function is compatible with both 'matlabpool' and 'parpool', but the
% latter one is more suggested. 
% 
% 2015-6-2 10:11:51

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

v=version; % Matlab version
v=str2num(v(1:3)); 

if v>=8.2 % for Matlab R2013b or later
    % the current pool size
    poolobj = gcp('nocreate');
    if isempty(poolobj) % no pool
        parpool(poolsize);
    elseif poolsize~=poolobj.NumWorkers % If the poolsize is different, then shutdown the old pool and create a new one.
        delete(gcp);
        parpool(poolsize);
    end
else
    currentpoolsize=matlabpool('size'); % the current pool size
    if currentpoolsize==0
        matlabpool(poolsize);
    elseif poolsize~=currentpoolsize
        matlabpool('close');
        matlabpool(poolsize);
    end
end