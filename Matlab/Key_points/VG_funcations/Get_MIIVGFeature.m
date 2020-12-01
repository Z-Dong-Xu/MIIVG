function VGFeature_list = Get_MIIVGFeature(input_img_cell,P_list_1, split, D)
%Get_VGFeature 接收Get_SURFPoints_Inf函数输出的关键点信息，和3层VG的模板
% 返回：各个关键点经过3层VG处理后的，第二层与第三层组成的特征向量
%   此处显示详细说明
keypoint_num = size(input_img_cell, 1);
% split = 3; %%%%可调
% D = 5;
VGFeature_list = zeros(split*split*size(P_list_1,2)*D, keypoint_num);

acount = 1;
while acount <= keypoint_num
    
    input = cell(1);
    temp = input_img_cell{acount};
    temp = temp{2};
    temp_size = size(temp,1);
    win_size = temp_size/split; %win_size 必须可以被3整除
    i = 1;
    while i<=split
        j = 1;
        while j<=split
             input{ (i-1)*split + j} = temp( (i-1)*win_size+1: i*win_size , (j-1)*win_size+1: j*win_size );
            j = j+1;
        end
        i = i+1;
    end

%% 1层VG处理9小图
    K_size = 1;
    Res_1 = MIIVG_Layer(input, P_list_1, K_size);
 %%  将第二层第三层VG特征拿出来组成特征向量
    VG_vect = zeros(split*split*size(P_list_1,2)*D,1);
    i = 1;
    while i <= split*split*size(P_list_1,2)
        temp = Res_1{i};
        temp = temp(:);
        temp_size = size(temp,1);
        hist = zeros(D,1);
        j = 1;
        while j <= temp_size
            value = floor(temp(j)*D);
            hist(value+1) = hist(value+1)+1;    %2020/04/05改正
            j = j+1;
        end
        VG_vect(D*(i-1)+1:D*i, 1) = hist(:);
        i = i+1;
    end

    VGFeature_list(:, acount) = VG_vect;
    
    %%
    acount = acount+1;
end

end

