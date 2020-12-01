function [H] = Get_Homography(Keypoint_1,Keypoint_2)
%Homography ����һ���Ӧ��keypoints��������Ӧ�ĵ�Ӧ�Ծ���H
%   Keypoint_1 Ϊ n��2�еľ��󣬵�һ��Ϊx���꣬�ڶ���Ϊy����
%   HΪ3*3���󣬵�Զ���4��ʱ����HΪ�������⣬����Ϊ��һ����ʹ����С���˷�
%   �˱任������Ϊ�������꣬��x���������£�y����������
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

