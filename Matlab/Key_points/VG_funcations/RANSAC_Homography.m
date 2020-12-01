function [RANSAC_H, Best_Right_Pair] = RANSAC_Homography(Index_list_1,Index_list_2, Match_list, Repeat)
%   UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   RANSAC_H��������󻯱��㷨�ж�Ϊƥ��Ĺؼ�����У�ʵ��ƥ���������
Best_H_fitness = 0;
Best_H = zeros(3);
i = 1;
while i<=Repeat

    Key_pair = size(Match_list, 1);
%     Limit_Dis = Match_list(0.6*size(Match_list,1),3); %��ȥ̫Զ��
    Limit = ceil(0.6*size(Match_list,1));
    rand_temp = randperm(Limit);
    rand_pointPair = rand_temp(1:4);   
    Keypoint_1 = Index_list_1(rand_pointPair, :);
    Keypoint_2 = Index_list_2(rand_pointPair, :);
    [H] = Get_Homography(Keypoint_1,Keypoint_2);
    
    [Key_trans] = HomoTrans_Points(H, Index_list_1);
    
    delat = Key_trans - Index_list_2;
    
    temp_H_fitness = 0; % ��¼inliers����
    Right_Pair = zeros(1);
    j = 1;
    while j<=Key_pair
        temp_D = (delat(j,1)^2+delat(j,2)^2)^0.5;
        if temp_D <= 3 %ŷʽ����С��3���ж�Ϊ��ȷ
            temp_H_fitness = temp_H_fitness + 1;
            Right_Pair (temp_H_fitness) = j;
        end
        j = j+1;
    end
    if temp_H_fitness > Best_H_fitness
        Best_Right_Pair = Right_Pair;
        Best_H_fitness = temp_H_fitness;
        Best_H = H;
    end
    i = i+1;
end

Keypoint_1 = Index_list_1(Best_Right_Pair, :);
Keypoint_2 = Index_list_2(Best_Right_Pair, :);
[RANSAC_H] = Get_Homography(Keypoint_1,Keypoint_2);

[Key_trans] = HomoTrans_Points(RANSAC_H, Index_list_1);
delat = Key_trans - Index_list_2;
temp_H_fitness = 0; % ��¼inliers����
Right_Pair = zeros(1);
j = 1;
while j<=Key_pair
    temp_D = (delat(j,1)^2+delat(j,2)^2)^0.5;
    if temp_D <= 3 %ŷʽ����С��3���ж�Ϊ��ȷ
        temp_H_fitness = temp_H_fitness + 1;
        Right_Pair (temp_H_fitness) = j;
    end
    j = j+1;
end

Best_Right_Pair = Right_Pair;

end

