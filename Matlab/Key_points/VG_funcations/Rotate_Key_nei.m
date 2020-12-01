function Rotate_image = Rotate_Key_nei(Input_image, Key_half_WinX, Key_half_WinY)
%Rotate_Key_nei  根据重心位置旋转图像
%输入大尺寸图，根据内部小尺寸对图进行旋转
%   此处显示详细说明
big_win = size(Input_image);
% big_win_X = big_win(1);
% big_win_Y = big_win(2);

Rotate_temp = Input_image;
%% 旋转图像，直到误差不超3度

Barycenter = get_Barycenter(Rotate_temp, Key_half_WinX, Key_half_WinY); %获取重心
angel = atan2(Barycenter(2), Barycenter(1));
angel = rad2deg(angel); %获取旋转角度

while abs(angel) >=1    %迭代旋转，当前后小于3度时停止选装
    Rotate_temp=imrotate(Rotate_temp,-angel,'bilinear', 'crop');
%     imshow(Rotate_temp);
    Barycenter = get_Barycenter(Rotate_temp, Key_half_WinX, Key_half_WinY);
    angel = atan2(Barycenter(2), Barycenter(1));
    angel = rad2deg(angel);
end
%% 取出中心的20*s的图
Xtemp = Key_half_WinX;
Ytemp = Key_half_WinY;

% Rotate_image = Rotate_temp( cen_y-Ytemp:cen_y+Ytemp, cen_x-Xtemp:cen_x+Xtemp );

input_X_cen = (big_win(2)+1)/2;
input_Y_cen = (big_win(1)+1)/2;
%截取中心小图返回
Rotate_image = Rotate_temp(input_Y_cen-Ytemp:input_Y_cen+Ytemp, input_X_cen-Xtemp:input_X_cen+Xtemp);


end

