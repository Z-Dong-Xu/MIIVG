%%
% 本代码实现了VG特征的提取和匹配，重构为MY_VG函数
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
I_size = size(input);

Degree_1 = 0;
Degree_2 = 90;

input_1=imrotate(input,Degree_1,'bilinear');

input_2=input;
input_2=imrotate(input_2,Degree_2,'bilinear');

%% 获取两张图片的keypoints及其邻域
Top_Strongest = 100;

Key_inf_res_1 = Get_SURFPoints_Inf(input_1,Top_Strongest);
Key_inf_res_2 = Get_SURFPoints_Inf(input_2,Top_Strongest);
%% 计算keypoints的邻域特征
P_list_1 = [0,235];

Split_subimg = 4;
His_D = 10;
VG_D = Split_subimg*Split_subimg*size(P_list_1,2)*His_D;

VG_vect_list_1 = Get_MIIVGFeature(Key_inf_res_1,P_list_1, Split_subimg, His_D);
VG_vect_list_2 = Get_MIIVGFeature(Key_inf_res_2,P_list_1, Split_subimg, His_D);
%% 计算两图片keypoints邻域特征的距离
Dis_Matrix = Dis_Matrix(VG_vect_list_1, VG_vect_list_2);

%%  由距离矩阵计算贪心匹配，并提取匹配后点对的矩阵坐标
Match_list = Match_keypoints(-Dis_Matrix);
[Index_list_1,Index_list_2] = KeyMatch_MatIndex(Key_inf_res_1, Key_inf_res_2, Match_list);

%% 绘制关键点之间的连线
GreenLine_plot(input_1,input_2,Index_list_1, Index_list_2, Match_list);

%% 单应性矩阵+RANSAC
[RANSAC_H, Right_Match_num] = RANSAC_Homography(Index_list_1,Index_list_2, Match_list, 60);

%%
[Right_max_acount] = Right_MAX(Key_inf_res_1,Key_inf_res_2,RANSAC_H);
[imgn] = HomoTrans_Img(input_1,RANSAC_H);
Percentage_Inliers = size(Right_Match_num,2)/size(Match_list,1);
Percentage_Inliers_Max = size(Right_Match_num,2)/Right_max_acount;


    
    