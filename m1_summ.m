% Summarize the evaluation results.
% 2016-3-24 20:05:46

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

load Ncut_eval.mat;
num_Ncut_MSC=num;
spi_Ncut_MSC=spi;
hom_Ncut_MSC=hom;
dic_Ncut_MSC=dic;

load SLIC_eval.mat;
num_Ncut_SLIC=num;
spi_Ncut_SLIC=spi;
hom_Ncut_SLIC=hom;
dic_Ncut_SLIC=dic;

num=[mean(num_Ncut_MSC,1); mean(num_Ncut_SLIC,1)];
spi=[mean(spi_Ncut_MSC,1); mean(spi_Ncut_SLIC,1)];
hom=[mean(hom_Ncut_MSC,1); mean(hom_Ncut_SLIC,1)];
dic=[mean(dic_Ncut_MSC,1); mean(dic_Ncut_SLIC,1)];

save('m1_summ.mat','num','spi','hom','dic');