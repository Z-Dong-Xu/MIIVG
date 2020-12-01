function [Res] = Gaussian_pyramid(Image, Gaussian_level)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
% ��˹����������Image����Gaussian_level��ĸ�˹������
%   �˴���ʾ��ϸ˵��
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

