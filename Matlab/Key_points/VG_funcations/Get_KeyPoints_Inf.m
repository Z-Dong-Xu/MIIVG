function Key_inf_res = Get_KeyPoints_Inf(input_image,Top_Strongest,big_win_X, big_win_Y,...
    Key_WinX,Key_WinY)
%UNTITLED ����ͼƬ�Լ��ؼ��������͹涨�������С��������ת��Ĺؼ��㼰��λ��
%���룺ͼƬ���ؼ����������󴰿ڴ�С��С���ڴ�С
%%  ���ڲ�ʹ�ô˺�����%%

corners = detectFASTFeatures(input_image);

res = corners.selectStrongest(Top_Strongest);
Point_Location_list = res.Location;
Key_X_list = Point_Location_list(:,1);
Key_Y_list = Point_Location_list(:,2);

% big_win = [51,51];  %��һ��ΪX���򣬵ڶ���ΪY����Y������ֱ����
% big_win_X = big_win(1);
% big_win_Y = big_win(2);
Xtemp = (big_win_X-1)/2;
Ytemp = (big_win_Y-1)/2;


Key_inf_list =cell(Top_Strongest,1);

i = 1;
catch_error = 0;
while i<=Top_Strongest
    
    Key_inf = cell(1,2);
    
    Key_X = Key_X_list(i);
    Key_Y = Key_Y_list(i);
    Key_Location = [Key_X, Key_Y];
    try
        Input_image = input_image( Key_Y-Ytemp:Key_Y+Ytemp, Key_X-Xtemp:Key_X+Xtemp );
    catch
        catch_error = catch_error+1;
        i = i+1;
        continue
    end
%     Key_Win = [31,31];%�ؼ��㴰�ڴ�С����һ��ΪX���򣬵ڶ���ΪY����Y������ֱ����
%     Key_WinX = Key_Win(1);
%     Key_WinY = Key_Win(2);

    Rotate_image = Rotate_Key_nei(Input_image, Key_WinX, Key_WinY);
    
    Key_inf{1} = Key_Location;
    Key_inf{2} = Rotate_image;
    
    Key_inf_list{i} = Key_inf;
    
    i = i+1;
end

Key_inf_res = cell(Top_Strongest-catch_error,1);
i = 1;
j = 1;
while i<=Top_Strongest
    if isempty(Key_inf_list{i}) == 0
        Key_inf_res{j} = Key_inf_list{i};
        j = j +1;
        i = i+1;
    else
        i = i+1;
    end
end


end

