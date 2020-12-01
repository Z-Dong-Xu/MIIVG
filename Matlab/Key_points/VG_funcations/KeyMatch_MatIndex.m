function [Index_list_1,Index_list_2] = KeyMatch_MatIndex(Key_inf_res1, Key_inf_res2, Match_list)
%   KeyMatch_MatIndex 用于按匹配生成keypoints的矩阵坐标
%   此处显示详细说明
Key_num = size(Match_list,1);
Index_list_1 = zeros(1, 2);
Index_list_2 = zeros(1, 2);
match = zeros(1,2);
i = 1;
while i<=Key_num
    match = Match_list(i, 1:2);     %取出一对匹配keypoints
    firstImg_key = match(1);        % 第一个keypoints
    secImg_key = match(2);          %第二个keypoints

    try
        index = Key_inf_res1{firstImg_key}{1};  %将第一个keypoints的欧式坐标取出，并转化为矩阵坐标
        Index_list_1(i, 1) = index(2);
        Index_list_1(i, 2) = index(1);
    catch
        index = Key_inf_res1(firstImg_key,:);  %将第一个keypoints的欧式坐标取出，并转化为矩阵坐标
        Index_list_1(i, 1) = index(2);
        Index_list_1(i, 2) = index(1);
    end
    try
        index = Key_inf_res2{secImg_key}{1};    %将第二个keypoints的欧式坐标取出，并转化为矩阵坐标
        Index_list_2(i, 1) = index(2);
        Index_list_2(i, 2) = index(1);
    catch
        index = Key_inf_res2(secImg_key,:);  %将第一个keypoints的欧式坐标取出，并转化为矩阵坐标
        Index_list_2(i, 1) = index(2);
        Index_list_2(i, 2) = index(1);
    end
    
    i = i+1;
end
end

