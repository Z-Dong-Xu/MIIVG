function Res = MIIVG_Texture_Feature(Image, Patch_list, step, Hist_num, ...
    Gaussian_level, Sampling_num)
%UNTITLED3 此处显示有关此函数的摘要
% 输入为：Image，单张图片；Patch_list，模式列表；Hist_num，box数；Gaussian_level，高斯金字塔层数
%   此处显示详细说明
Patch_num = max(size(Patch_list));

Res = zeros(Patch_num * Hist_num * Gaussian_level, 1);

Gaussian_pyramid_images = Gaussian_pyramid(Image, Gaussian_level);
p = 1;
while p <= Gaussian_level
    Gaussian_images = Gaussian_pyramid_images{p};
    sub_image = Image_Sampling_1(Gaussian_images, Sampling_num);
    s = 1;
    while s <= Sampling_num
        j = 1;
        while j <= Patch_num
            VG_res = MIIVG_Scan( sub_image{s}, Patch_list(j), step);

            VG_res_temp = VG_res(:);
            pix_num = size(VG_res_temp,1);
            feature_temp = zeros(Hist_num,1);
            k = 1;
            while k <= pix_num
                flag = floor(VG_res_temp(k) * Hist_num);
                feature_temp(flag+1) = feature_temp(flag+1)+1; 
                k = k+1;
            end
            feature_temp = feature_temp/pix_num;
            Res((p-1)*(Patch_num*Hist_num*Sampling_num) +(s-1)*(Patch_num*Hist_num)+ (j-1)*Hist_num+1 :  ...
                (p-1)*(Patch_num*Hist_num*Sampling_num)+(s-1)*(Patch_num*Hist_num)+j*Hist_num , 1) = feature_temp(:);

    %         fprintf('已完成： Gaussian_pyramid:%d  Patch:%d \n', p,j);
            j = j+1;
        end
        s = s+1;
    end
    p = p+1;
end

end

