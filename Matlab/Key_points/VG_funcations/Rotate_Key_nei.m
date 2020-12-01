function Rotate_image = Rotate_Key_nei(Input_image, Key_half_WinX, Key_half_WinY)
%Rotate_Key_nei  ��������λ����תͼ��
%�����ߴ�ͼ�������ڲ�С�ߴ��ͼ������ת
%   �˴���ʾ��ϸ˵��
big_win = size(Input_image);
% big_win_X = big_win(1);
% big_win_Y = big_win(2);

Rotate_temp = Input_image;
%% ��תͼ��ֱ������3��

Barycenter = get_Barycenter(Rotate_temp, Key_half_WinX, Key_half_WinY); %��ȡ����
angel = atan2(Barycenter(2), Barycenter(1));
angel = rad2deg(angel); %��ȡ��ת�Ƕ�

while abs(angel) >=1    %������ת����ǰ��С��3��ʱֹͣѡװ
    Rotate_temp=imrotate(Rotate_temp,-angel,'bilinear', 'crop');
%     imshow(Rotate_temp);
    Barycenter = get_Barycenter(Rotate_temp, Key_half_WinX, Key_half_WinY);
    angel = atan2(Barycenter(2), Barycenter(1));
    angel = rad2deg(angel);
end
%% ȡ�����ĵ�20*s��ͼ
Xtemp = Key_half_WinX;
Ytemp = Key_half_WinY;

% Rotate_image = Rotate_temp( cen_y-Ytemp:cen_y+Ytemp, cen_x-Xtemp:cen_x+Xtemp );

input_X_cen = (big_win(2)+1)/2;
input_Y_cen = (big_win(1)+1)/2;
%��ȡ����Сͼ����
Rotate_image = Rotate_temp(input_Y_cen-Ytemp:input_Y_cen+Ytemp, input_X_cen-Xtemp:input_X_cen+Xtemp);


end

