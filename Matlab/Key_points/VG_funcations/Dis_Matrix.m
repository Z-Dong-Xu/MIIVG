function Dis_Matrix = Dis_Matrix(VG_vect_list_1, VG_vect_list_2)
%Dis_Matrix ����VG_vect����֮��ľ���
%   �˴���ʾ��ϸ˵��
keypoint_num_1 = size(VG_vect_list_1, 2);
keypoint_num_2 = size(VG_vect_list_2, 2);
Dis_Matrix = zeros(keypoint_num_1,keypoint_num_2);

i = 1;
while i<=keypoint_num_1
    j = 1;
    while j <= keypoint_num_2
        temp = VG_vect_list_1(:,i) - VG_vect_list_2(:, j);
%         Dis_Matrix(i,j) = power(sum(power(temp, 2)), 0.5); %ŷʽ����
        Dis_Matrix(i,j) = sum(abs(temp)); % ֱ�Ǿ���

%         temp = corrcoef(VG_vect_list_1(:,i), VG_vect_list_2(:, j));
%         Dis_Matrix(i,j) = temp(1,2);   % ���ϵ��
%         Dis_Matrix(i,j) = sum(VG_vect_list_1(:,i).*VG_vect_list_2(:, j));   % �����ϵ��
        j = j+1;
    end
    i = i+1;
end
end

