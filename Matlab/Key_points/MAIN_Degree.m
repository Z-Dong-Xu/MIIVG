%%
% 本代码实现VG的Degree扫描
%%
clear ;
warning('off');

Your_path = "E:\MY_FILES\VGNN";

input_1_cell = cell(30,1);
Image_num = 30;
Number = 1;
while Number<=Image_num
    name_1 = "\MIIVG\images\Image_Set\img_";
    name_2 = num2str(Number);
    name_3 = ".jpg";
    file_name = strcat(Your_path, name_1,name_2,name_3);
    
    Image=imread(file_name);
    Image = im2double(Image);
    input = 0.3*Image(:,:,1)+0.5*Image(:,:,2)+0.2*Image(:,:,3);
    input=histeq(input); 
    
    input_1_cell{Number} = input;
    
    Number = Number+1;
end


Top_Strongest = 100;
Split_subimg = 4;
% P_list_1 = [0,235];
P_list_1 = [0];
His_D = 10;
VG_D = Split_subimg*Split_subimg*size(P_list_1,2)*His_D;


step = 5;
Max_Degree = 360;
Percentage_Inliers_recode = zeros(1,round(Max_Degree/step));
Percentage_Inliers_MAX_recode = zeros(1,round(Max_Degree/step));
Degree_list = zeros(1,round(Max_Degree/step));


Degree = 0;
acount = 1;
while Degree <= Max_Degree
    Degree_list(acount) = Degree;
    Percentage_Inliers_MAX = 0;
    Percentage_Inliers = 0;
    i = 1;
    while i <= Image_num
        input_1 = input_1_cell{i};
        input_2=imrotate(input_1,Degree,'bilinear');

        [Match_list, RANSAC_H,Right_Match_num, T, Dis_M, Right_max_acount] = ...
            MIIVG_keypoint_match(input_1,input_2, Top_Strongest, P_list_1, Split_subimg, His_D);

        Percentage_Inliers_MAX = Percentage_Inliers_MAX+size(Right_Match_num,2)/Right_max_acount;
        Percentage_Inliers = Percentage_Inliers + size(Right_Match_num,2)/size(Match_list,1);
        fprintf('已完成：第%d个:第%d个\n', acount,i);
        i = i+1;
    end
    Percentage_Inliers_recode(acount) = Percentage_Inliers/Image_num;
    Percentage_Inliers_MAX_recode(acount) = Percentage_Inliers_MAX/Image_num;
    Degree = Degree+step;
    acount = acount + 1;
    
end



