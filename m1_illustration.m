% Draw the illustrations for the parcellations of Ncut and SLIC with 100, 
% 300 and 800 clusters. 
% 2016-4-8 13:19:11

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

cSub=1; % choose a subject

gunzip('T1_4mm.nii.gz');
nii=load_untouch_nii('T1_4mm.nii');
img_bg=nii.img;

temp=[];
for i=1:2
    % a method for each row, Ncut & SLIC
    if i==1
        method='Ncut';
    elseif i==2
        method='SLIC';
    end
    
    tmp=[];
    for j=1:3
        % initialized cluster number, 100, 300 & 800
        if j==1
            cK=100;
        elseif j==2
            cK=300;
        elseif j==3
            cK=800;
        end
        
        nii=load_untouch_nii(sprintf('%s_sub_parc/sub%05d_K%d.nii',method,cSub,cK));
        img_parc=nii.img;
        opt=1;
        img_orth=parc_orthview(img_bg,img_parc,opt);
        img_orth=single(img_orth/255);
        
        tmp=[tmp,img_orth];
    end
    
    temp=[temp;tmp];
end
img_orth=temp;

imshow(img_orth,'border','tight');