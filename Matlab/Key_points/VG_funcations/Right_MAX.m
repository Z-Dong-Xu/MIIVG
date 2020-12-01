function [Right_max_acount] = Right_MAX(Key_inf_res_1,Key_inf_res_2,RANSAC_H)
%   Right_MAX��ʹ��RANSAC_H���������ҵĵĹؼ�����б任��ͳ�ƾ���3���ڵĵ㣬��Ϊʵ��ƥ��Ĺ���
%   ע�⣺�˴������ƥ����������RANSAC_H����ʱ�����ƥ������ǲ�ͬ�ģ�����RANSAC_H����ʱ...
%   ������㷨ƥ���ϵĵ����ʵ��ƥ��������������㷨��һ��ƥ�����ִ��������������ֵ���䲻ͬ��
%   ��ͬ�Ļ�����100%��PMֵ��

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
        Dis_Matrix_temp(i,j) = power(sum(power(temp, 2)), 0.5); %ŷʽ����
        j = j+1;
    end
    i = i+1;
end

Match_list_temp = Match_keypoints(-Dis_Matrix_temp);
Right_max_acount = size(find(Match_list_temp(:,3)>=-3),1);
end

