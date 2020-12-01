function [Index_list_1,Index_list_2] = KeyMatch_MatIndex(Key_inf_res1, Key_inf_res2, Match_list)
%   KeyMatch_MatIndex ���ڰ�ƥ������keypoints�ľ�������
%   �˴���ʾ��ϸ˵��
Key_num = size(Match_list,1);
Index_list_1 = zeros(1, 2);
Index_list_2 = zeros(1, 2);
match = zeros(1,2);
i = 1;
while i<=Key_num
    match = Match_list(i, 1:2);     %ȡ��һ��ƥ��keypoints
    firstImg_key = match(1);        % ��һ��keypoints
    secImg_key = match(2);          %�ڶ���keypoints

    try
        index = Key_inf_res1{firstImg_key}{1};  %����һ��keypoints��ŷʽ����ȡ������ת��Ϊ��������
        Index_list_1(i, 1) = index(2);
        Index_list_1(i, 2) = index(1);
    catch
        index = Key_inf_res1(firstImg_key,:);  %����һ��keypoints��ŷʽ����ȡ������ת��Ϊ��������
        Index_list_1(i, 1) = index(2);
        Index_list_1(i, 2) = index(1);
    end
    try
        index = Key_inf_res2{secImg_key}{1};    %���ڶ���keypoints��ŷʽ����ȡ������ת��Ϊ��������
        Index_list_2(i, 1) = index(2);
        Index_list_2(i, 2) = index(1);
    catch
        index = Key_inf_res2(secImg_key,:);  %����һ��keypoints��ŷʽ����ȡ������ת��Ϊ��������
        Index_list_2(i, 1) = index(2);
        Index_list_2(i, 2) = index(1);
    end
    
    i = i+1;
end
end

