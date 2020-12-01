function [Key_trans] = HomoTrans_Points(H, Keypoint_1)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
Key_num = size(Keypoint_1, 1);
Key_trans = zeros(Key_num, 2);
i = 1;
while i<=Key_num
    keypoint_First = Keypoint_1(i,:);
    keypoint_First(3) = 1;
    keypoint_First_trans = H*keypoint_First';
    keypoint_First_trans = keypoint_First_trans/keypoint_First_trans(3);
    
    Key_trans(i,1:2) = keypoint_First_trans(1:2);
    i = i+1;
end

end

