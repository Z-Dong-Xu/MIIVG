%%
% 本代码实现VG的256个Patch扫描
%%
clear ;
warning('off');

Your_path = "E:\MY_FILES\VGNN";
name_1 = "\MIIVG\images\SH.jpg";
file_name = strcat(Your_path, name_1);

Image=imread(file_name);
Image = im2double(Image);
input = 0.3*Image(:,:,1)+0.5*Image(:,:,2)+0.2*Image(:,:,3);
input=histeq(input); 

input_1 = input;

input_2_list = cell(73,1);
step = 5;
Max_Degree = 360;
Degree = 0;
acount = 1;
while Degree <= Max_Degree
    input_2_list{acount} = imrotate(input,Degree,'bilinear');
    
    Degree = Degree+step;
    acount = acount+1;
end



Top_Strongest = 115;
Split_subimg = 3;
% P_list_1 = [0,235];
P_list_1 = [0];
His_D = 10;
VG_D = Split_subimg*Split_subimg*size(P_list_1,2)*His_D;

Percentage_Inliers_recode = zeros(256,round(Max_Degree/step));
Percentage_Inliers_MAX_recode = zeros(256,round(Max_Degree/step));

Size_list = size(input_2_list,1);
patch = 0;
while patch <= 255
    acount = 1;
    while acount <= Size_list
        
        input_2=input_2_list{acount};

        P_list_1 = [patch];

        [Match_list, RANSAC_H,Right_Match_num, T, Dis_M, Right_max_acount] = ...
            MIIVG_keypoint_match(input_1,input_2, Top_Strongest, P_list_1, Split_subimg, His_D);

        Percentage_Inliers = size(Right_Match_num,2)/size(Match_list,1);
        Percentage_Inliers_MAX = size(Right_Match_num,2)/Right_max_acount;
        Percentage_Inliers_recode(patch+1, acount) = Percentage_Inliers;
        Percentage_Inliers_MAX_recode(patch+1, acount) = Percentage_Inliers_MAX;

        fprintf('已完成：第%d个:第%d个\n',patch+1, acount);
        acount = acount + 1;

    end
    patch = patch+1;
end











