function [Res] = Gaussian_pyramid(Image, Gaussian_level)
%UNTITLED3 此处显示有关此函数的摘要
% 高斯金字塔：对Image生成Gaussian_level层的高斯金字塔
%   此处显示详细说明
Res = cell(Gaussian_level, 1);
w=fspecial('gaussian',[3 3]);

Res{1} = Image;
temp = Image;
i = 2;
while i <= Gaussian_level
    [m,n]=size(temp);
    img=imresize(imfilter(temp,w),[m/2 n/2]);
    Res{i} = img;
    temp = img;
    i = i + 1;
end

end

