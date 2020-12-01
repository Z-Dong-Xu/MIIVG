function Res = MIIVG_Layer(input, Patch_list, step)
%   VG_Layer：对一组图片进行VG计算
%   input：一组灰度图存在cell中，Patch_list：使用的模式列表，step：计算步长, FLAG：原来为5,现在不用了
input_size = max(size(input));
P_num = max(size(Patch_list));
Res = cell(input_size*P_num, 1);

acount = 1;
i = 1;
while i<=input_size
    j = 1;
    while j <= P_num
        VG_res = MIIVG_Scan( input{i}, Patch_list(j), step);
        Res{acount} = VG_res;
        j = j+1;
        acount = acount+1;
    end
    i = i+1;
end

end

