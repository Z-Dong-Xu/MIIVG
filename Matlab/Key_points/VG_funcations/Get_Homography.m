function [H] = Get_Homography(Keypoint_1,Keypoint_2)
%Homography 传入一组对应的keypoints，返回相应的单应性矩阵H
%   Keypoint_1 为 n行2列的矩阵，第一列为x坐标，第二列为y坐标
%   H为3*3矩阵，点对多于4对时，解H为超定问题，所以为了一般性使用最小二乘法
%   此变换的坐标为矩阵坐标，即x正方向向下，y正方向向右
Keypoint_num = size(Keypoint_1,1);
A = zeros(2*Keypoint_num,9);

A(1:2:2*Keypoint_num,1:2) = Keypoint_1;
A(1:2:2*Keypoint_num,3) = 1;
A(2:2:2*Keypoint_num,4:5) = Keypoint_1;
A(2:2:2*Keypoint_num,6) = 1;

x1 = Keypoint_1(:, 1);
y1 = Keypoint_1(:, 2);
x2 = Keypoint_2(:, 1);
y2 = Keypoint_2(:, 2);
A(1:2:2*Keypoint_num,7) = -x2.*x1;
A(2:2:2*Keypoint_num,7) = -y2.*x1;
A(1:2:2*Keypoint_num,8) = -x2.*y1;
A(2:2:2*Keypoint_num,8) = -y2.*y1;
A(1:2:2*Keypoint_num,9) = -x2;
A(2:2:2*Keypoint_num,9) = -y2;

% B = [0,0,0,0,0,0,0,0]';
% evec = A\B;
[evec,~] = eig(A'*A);
H = reshape(evec(:,1),[3,3])';
H = H/H(end); % make H(3,3) = 1

end

