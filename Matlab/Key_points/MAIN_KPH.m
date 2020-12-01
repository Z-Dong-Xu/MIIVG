%%
% 本代码实现子区域K模板数P直方图H的超参数选择
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

Repeat = 50;
Degree_1 = 0;
Degree_list = unifrnd(0, 360, 1, Repeat);

input_1 = input;
% input_2=imresize(input,[600,400]);

Top_Strongest = 115;
Split_subimg_list = [2,3,4];
P_cell = cell(1,3);
P_cell{1} = [0];
P_cell{2} = [0,235];
P_cell{3} = [0,95,235];
His_D_list = [4,5,8,10,20];


Percentage_Inliers_recode = zeros(size(Split_subimg_list,2),size(P_cell,2),size(His_D_list,2));
Run_time_recode = zeros(size(Split_subimg_list,2),size(P_cell,2),size(His_D_list,2));

i = 1;
while i <= size(Split_subimg_list,2)
    j = 1;
    while j <=size(P_cell,2)
        k = 1;
        while k <= size(His_D_list,2)
            Split_subimg = Split_subimg_list(i);
            P_list_1 = P_cell{j};
            His_D = His_D_list(k);
            VG_D = Split_subimg*Split_subimg*size(P_list_1,2)*His_D;
            p = 1;
            Percentage_Inliers_temp = zeros(1,Repeat);
            Run_time_temp = zeros(1,Repeat);
            while p <= Repeat
                Degree_2 =  Degree_list(p);
                input_2=imrotate(input,Degree_2,'bilinear');
                [Match_list, RANSAC_H,Right_Match_num, T, Dis_M,Right_max_acount] = ...
                    MIIVG_keypoint_match(input_1,input_2, Top_Strongest, P_list_1, Split_subimg, His_D);
                Percentage_Inliers = size(Right_Match_num,2)/size(Match_list,1);
                Percentage_Inliers_temp(p) = Percentage_Inliers;
                Run_time_temp(p) = T;
                fprintf('已完成：第%d个:第%d个\n', (i-1)*15+(j-1)*5+k, p);
                p = p+1;
            end
            Percentage_Inliers_recode(i,j,k) = mean(Percentage_Inliers_temp);
            Run_time_recode(i,j,k) = mean(Run_time_temp);
            fprintf('已完成：第%d个\n', (i-1)*15+(j-1)*5+k);
            k = k+1;
        end
        j = j+1;
    end
    i = i+1;
end




