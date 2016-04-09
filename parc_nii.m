function parc_nii(file_mask,file_out,img_parc)
% Save the parcellation results into .nii file. Usually the type of img in
% the maskfile is single or int16, but the type of label is double, so we
% should transform the data type before saving the result to the .nii file.
% 2014-10-21 20:51:07

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

nii=load_untouch_nii(file_mask);
nii.img=cast(img_parc,class(nii.img));
save_untouch_nii(nii,file_out);