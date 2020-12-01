function Res = MIIVG_Layer(input, Patch_list, step)
%   VG_Layer����һ��ͼƬ����VG����
%   input��һ��Ҷ�ͼ����cell�У�Patch_list��ʹ�õ�ģʽ�б�step�����㲽��, FLAG��ԭ��Ϊ5,���ڲ�����
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

