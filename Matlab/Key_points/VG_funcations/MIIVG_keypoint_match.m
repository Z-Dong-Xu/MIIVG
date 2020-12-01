function [Match_list, RANSAC_H,Right_Match_num, T, Dis_M,Right_max_acount] = MIIVG_keypoint_match(input_1,input_2, Top_Strongest, P_list_1, ...
    Split_subimg, His_D)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%% ��ȡ����ͼƬ��keypoints��������

Key_inf_res_1 = Get_SURFPoints_Inf(input_1,Top_Strongest);
Key_inf_res_2 = Get_SURFPoints_Inf(input_2,Top_Strongest);
%% ����keypoints����������
t1=clock;
VG_vect_list_1 = Get_MIIVGFeature(Key_inf_res_1,P_list_1, Split_subimg, His_D);
VG_vect_list_2 = Get_MIIVGFeature(Key_inf_res_2,P_list_1, Split_subimg, His_D);
%% ������ͼƬkeypoints���������ľ���
Dis_M = Dis_Matrix(VG_vect_list_1, VG_vect_list_2);

%%  �ɾ���������̰��ƥ�䣬����ȡƥ����Եľ�������
Match_list = Match_keypoints(-Dis_M);
t2=clock;
T = etime(t2,t1);
[Index_list_1,Index_list_2] = KeyMatch_MatIndex(Key_inf_res_1, Key_inf_res_2, Match_list);
%% ���ƹؼ���֮�������
% GreenLine_plot(input_1,input_2,Index_list_1, Index_list_2, Match_list);
%% ��Ӧ�Ծ���+RANSAC
[RANSAC_H, Right_Match_num] = RANSAC_Homography(Index_list_1,Index_list_2, Match_list, 1000);

[Right_max_acount] = Right_MAX(Key_inf_res_1,Key_inf_res_2,RANSAC_H);
end

