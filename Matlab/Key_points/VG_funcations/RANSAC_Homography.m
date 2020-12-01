function [RANSAC_H, Best_Right_Pair] = RANSAC_Homography(Index_list_1,Index_list_2, Match_list, Repeat)
%   UNTITLED2 此处显示有关此函数的摘要
%   RANSAC_H：可以最大化被算法判定为匹配的关键点对中，实际匹配的数量。
Best_H_fitness = 0;
Best_H = zeros(3);
i = 1;
while i<=Repeat

    Key_pair = size(Match_list, 1);
%     Limit_Dis = Match_list(0.6*size(Match_list,1),3); %舍去太远的
    Limit = ceil(0.6*size(Match_list,1));
    rand_temp = randperm(Limit);
    rand_pointPair = rand_temp(1:4);   
    Keypoint_1 = Index_list_1(rand_pointPair, :);
    Keypoint_2 = Index_list_2(rand_pointPair, :);
    [H] = Get_Homography(Keypoint_1,Keypoint_2);
    
    [Key_trans] = HomoTrans_Points(H, Index_list_1);
    
    delat = Key_trans - Index_list_2;
    
    temp_H_fitness = 0; % 记录inliers数量
    Right_Pair = zeros(1);
    j = 1;
    while j<=Key_pair
        temp_D = (delat(j,1)^2+delat(j,2)^2)^0.5;
        if temp_D <= 3 %欧式距离小于3的判定为正确
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
temp_H_fitness = 0; % 记录inliers数量
Right_Pair = zeros(1);
j = 1;
while j<=Key_pair
    temp_D = (delat(j,1)^2+delat(j,2)^2)^0.5;
    if temp_D <= 3 %欧式距离小于3的判定为正确
        temp_H_fitness = temp_H_fitness + 1;
        Right_Pair (temp_H_fitness) = j;
    end
    j = j+1;
end

Best_Right_Pair = Right_Pair;

end

