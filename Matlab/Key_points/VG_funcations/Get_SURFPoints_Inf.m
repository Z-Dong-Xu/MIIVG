function Key_inf_res = Get_SURFPoints_Inf(input,Top_Strongest)
%Get_SURFPoints_Inf ����һ��ͼƬ����Ҫ�Ĺؼ�������
%����SURF�ؼ�����������ת������������С�ڳ�������ע��    VG_size
%���ص�Ϊcell
%   �˴���ʾ��ϸ˵��

%% ��ȡSURF�ؼ��㣬̽Ѱ��
total_points = detectSURFFeatures(input);

select_points = total_points.selectStrongest(Top_Strongest);

Point_Location_list = select_points.Location;
Key_X_list = Point_Location_list(:,1);
Key_Y_list = Point_Location_list(:,2);

Point_Scale = select_points.Scale;      %��ȡ�߶�

Key_inf_list =cell(Top_Strongest,1);
%% ��ȡ�ؼ�������򣨸��ݳ߶�ȷ�������С��������ת
i = 1;
catch_error = 0;
while i<=Top_Strongest
    
    Key_half_WinX = ceil( 10*Point_Scale(i) );          %���ݳ߶Ȼ������ڴ�С
    Key_half_WinY = Key_half_WinX;
    
    half_big_win_X = floor( 1.5*Key_half_WinX );        %���ݳ߶Ȼ����󴰿ڴ�С
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
  
    VG_size = [30,30];      %��������Ĵ�С
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
%% �޳����򳬳���Χ��keypoints
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

