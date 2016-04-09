% The main script. The two .png files contain the final results for check.
% 2016-4-8 15:57:14

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

m1_download;     % Download the NIFTI toolbox and Craddock's demo data
m1_prepare;      % Prepare for parcellation
m1_parc;         % Perform parcellation
m1_illustration; % Draw illustratons
m1_eval;         % Calculate evaluation metrics
m1_summ;         % Summarize the evaluation metrics
m1_plot;         % Plot the evaluation metrics