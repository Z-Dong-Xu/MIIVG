function Res = MIIVG_Scan(X, code, step)
%   VG_Scan： 对一张灰度图进行VG特征图计算
%   X：为输入的灰度图，code：为使用到的code，step：为计算步长=1，FLAG：原来有用，现在没用
%   此处显示详细说明
shape_X = size(X);
high = shape_X(1);
weight = shape_X(2);
Res = zeros(floor(high/step)+step-3, floor(weight/step)+step-3);
%%
Patch_origin_code = [0 0 0 0 0 0 0 0];
Patch_origin = [1,-2,1,0,0,0,0,0,0;
       0,0,0,1,-2,1,0,0,0;
       0,0,0,0,0,0,1,-2,1;
       1,0,0,-2,0,0,1,0,0;
       0,1,0,0,-2,0,0,1,0;
       0,0,1,0,0,-2,0,0,1;
       1,0,0,0,-2,0,0,0,1;
       0,0,1,0,-2,0,1,0,0;
        ]; 
b_origin = -Patch_origin;

Patch_bin = dec2bin(code, 8);
Patch_code = str2num(Patch_bin(:))';

Patch_delat = (-2*Patch_code+1)';

b = b_origin .* Patch_delat;
Kenal = sum(b);
Kenal = reshape(Kenal, 3,3)';

%%
Res = conv2(X,Kenal,"valid");
Res = 1./(1+exp(-Res));

end



