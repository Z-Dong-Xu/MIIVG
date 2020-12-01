function [Right_max_acount] = Right_MAX(Key_inf_res_1,Key_inf_res_2,RANSAC_H)
%   Right_MAX：使用RANSAC_H，对所有找的的关键点进行变换，统计距离3以内的点，作为实际匹配的估计
%   注意：此处计算的匹配点数与计算RANSAC_H矩阵时计算的匹配点数是不同的，计算RANSAC_H矩阵时...
%   是最大化算法匹配上的点对中实际匹配的数量，由于算法第一次匹配会出现错误，所以这里的数值与其不同，
%   相同的话代表100%的PM值。

Key_posi_1 = zeros(size(Key_inf_res_1,1),2);
Key_posi_2 = zeros(size(Key_inf_res_2,1),2);

i = 1;
while i <= size(Key_inf_res_1,1)
    try
        temp = Key_inf_res_1{i}{1}; 
    catch
        temp = Key_inf_res_1(i,:); 
    end
    Key_posi_1(i,1) = temp(2);
    Key_posi_1(i,2) = temp(1);
    i = i+1;
end

i = 1;
while i <= size(Key_inf_res_2,1)
    try
        temp = Key_inf_res_2{i}{1}; 
    catch
        temp = Key_inf_res_2(i,:); 
    end
    Key_posi_2(i,1) = temp(2);
    Key_posi_2(i,2) = temp(1);
    i = i+1;
end

[Key_trans] = HomoTrans_Points(RANSAC_H, Key_posi_1);


keypoint_num_1 = size(Key_trans, 1);
keypoint_num_2 = size(Key_posi_2, 1);
Dis_Matrix_temp = zeros(keypoint_num_1,keypoint_num_2);

i = 1;
while i<=keypoint_num_1
    j = 1;
    while j <= keypoint_num_2
        temp = Key_trans(i,:) - Key_posi_2(j,:);
        Dis_Matrix_temp(i,j) = power(sum(power(temp, 2)), 0.5); %欧式距离
        j = j+1;
    end
    i = i+1;
end

Match_list_temp = Match_keypoints(-Dis_Matrix_temp);
Right_max_acount = size(find(Match_list_temp(:,3)>=-3),1);
end

