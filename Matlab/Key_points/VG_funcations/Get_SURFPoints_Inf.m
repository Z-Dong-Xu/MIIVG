function Key_inf_res = Get_SURFPoints_Inf(input,Top_Strongest)
%Get_SURFPoints_Inf 输入一张图片和需要的关键点数量
%返回SURF关键点的坐标和旋转后的邻域，邻域大小在程序内有注释    VG_size
%返回的为cell
%   此处显示详细说明

%% 提取SURF关键点，探寻器
total_points = detectSURFFeatures(input);

select_points = total_points.selectStrongest(Top_Strongest);

Point_Location_list = select_points.Location;
Key_X_list = Point_Location_list(:,1);
Key_Y_list = Point_Location_list(:,2);

Point_Scale = select_points.Scale;      %提取尺度

Key_inf_list =cell(Top_Strongest,1);
%% 提取关键点的邻域（根据尺度确定邻域大小），并旋转
i = 1;
catch_error = 0;
while i<=Top_Strongest
    
    Key_half_WinX = ceil( 10*Point_Scale(i) );          %根据尺度划定窗口大小
    Key_half_WinY = Key_half_WinX;
    
    half_big_win_X = floor( 1.5*Key_half_WinX );        %根据尺度划定大窗口大小
    half_big_win_Y =  floor( 1.5*Key_half_WinY );
    
    Xtemp = half_big_win_X;
    Ytemp = half_big_win_Y;

    
    Key_inf = cell(1,2);
    
    Key_Location = [Key_X_list(i), Key_Y_list(i)];
    Key_X = round(Key_X_list(i) );%
    Key_Y = round(Key_Y_list(i) );%
    try
        Input_image = input( Key_Y-Ytemp:Key_Y+Ytemp, Key_X-Xtemp:Key_X+Xtemp );
    catch
        catch_error = catch_error+1;
        i = i+1;
        continue
    end
 
    Rotate_image = Rotate_Key_nei( Input_image, Key_half_WinX, Key_half_WinY ); 
  
    VG_size = [30,30];      %返回邻域的大小
    VG_input=imresize(Rotate_image,[VG_size(1),VG_size(2)]);
%     h = fspecial('gaussian', 3, 0.6);
%     VG_input = imfilter(VG_input, h);
%     VG_input=imresize(VG_input,[18,18]);
%     VG_input = imfilter(VG_input, h);
%     VG_input=imresize(VG_input,[9,9]);
       
    Key_inf{1} = Key_Location;
    h = fspecial('gaussian', 3, 0.6);
    VG_input =  imfilter(VG_input, h);
    VG_input=histeq(VG_input); 
    Key_inf{2} = VG_input;
    
    Key_inf_list{i} = Key_inf;
    
    i = i+1;
end
%% 剔除邻域超出范围的keypoints
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

