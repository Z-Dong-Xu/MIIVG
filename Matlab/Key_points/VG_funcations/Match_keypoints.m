function Match_list = Match_keypoints(Dis_Matrix)
%	基于距离矩阵进行贪心匹配
%   此处显示详细说明
    Keypoint_num1 = size(Dis_Matrix, 1);
    Keypoint_num2 = size(Dis_Matrix, 2);
    D_Size = min(Keypoint_num1, Keypoint_num2);
    Keypoint_flag_1 = zeros(Keypoint_num1, 1);
    Keypoint_flag_2 = zeros(Keypoint_num2, 1);
    Match_list = zeros(D_Size, 3);
    INF =10000;

    FLAG = 0;
    while FLAG < D_Size
        M=max(max(Dis_Matrix));
        [row,col]=find(Dis_Matrix==M);
        Dis_Matrix(row(1),col(1)) = -INF; 
        if (Keypoint_flag_1(row(1))==0) && (Keypoint_flag_2(col(1))==0)
            FLAG = FLAG+1;
            Keypoint_flag_1(row(1)) = 1;
            Keypoint_flag_2(col(1)) = 1;
            Match_list(FLAG,1) = row(1);
            Match_list(FLAG,2) = col(1);
            Match_list(FLAG,3) = M;
        else
            continue
        end

    end
    
end

