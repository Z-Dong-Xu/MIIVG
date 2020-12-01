function [Sampling_Cell] = Image_Sampling_1(Image, Sampling_num)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
spilt = sqrt(Sampling_num);
Sampling_Cell = cell(Sampling_num, 1);

Image_size = size(Image);

Sampling_Win_H = floor( Image_size(1)/spilt );
Sampling_Win_W = floor( Image_size(2)/spilt );

i = 1;
while i<=spilt
    j = 1;
    while j<=spilt
        X = (i -1)*Sampling_Win_H;
        Y = (j -1)*Sampling_Win_W;
        temp = Image( X+1:X+Sampling_Win_H, Y+1:Y+Sampling_Win_W);
        Sampling_Cell{ (i-1)*spilt+j } = temp;
        j = j+1;
    end
    i = i+1;
end

end

