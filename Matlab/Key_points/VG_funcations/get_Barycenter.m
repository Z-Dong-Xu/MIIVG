function  Barycenter = get_Barycenter(input_image, win_half_Xsize, win_half_Ysize)
%UNTITLED 此处显示有关此函数的摘要
%图像的X方向为水平向右，Y方向为垂直向上,返回值为Barycenter（X，Y）
%win_Xsize, win_Ysize为计算重心的窗口大小，窗口在中心处
%   此处显示详细说明

input_image=histeq(input_image); 
Barycenter = zeros(1,2);

Xtemp = win_half_Xsize;
Ytemp = win_half_Ysize;

input_size = size(input_image);
input_X_cen = (input_size(2)+1)/2;
input_Y_cen = (input_size(1)+1)/2;

image = input_image(input_Y_cen-Ytemp:input_Y_cen+Ytemp, input_X_cen-Xtemp:input_X_cen+Xtemp);
Size_image = size(image,1);
[ c ] = genCircle(Size_image, (Size_image-1)/2-1);
image = image.*c;

img_size = size(image);
X_size = img_size(2);
Y_size = img_size(1);
X_cen = (X_size+1)/2;
Y_cen = (Y_size+1)/2;

Y_sum = sum(image);
X_sum = sum(image,2);
Total_sum = sum(image, "all");

i = 1;
moment_X = 0;
while i <= X_size    
    moment_X = moment_X + (i-X_cen)*Y_sum(i); 
    i = i+1;
end

i = 1;
moment_Y = 0;
while i <= Y_size    
    moment_Y = moment_Y + (-(i-Y_cen))*X_sum(i); 
    i = i+1;
end

Barycenter(1) = moment_X/Total_sum;
Barycenter(2) = moment_Y/Total_sum;

end

