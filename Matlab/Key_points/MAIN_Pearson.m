clear ;
warning('off');
% ��Ӧ��Draw_Pearson
repeat = 1000;
Recode = zeros(repeat, 256);

i = 1;
while i <= 5000
    X = rand(3, 3);
    patch = 0;
    while patch <= 255        
        res = MIIVG_Scan(X, patch, 1);
        Recode(i, patch+1) = res;
        patch = patch + 1;
    end
    if mod(i,100) == 0
        fprintf('����ɣ���%d��\n', i);
    end
    i = i+1;
end

tic
Pearson_Matrix = corr(Recode,'type','Pearson');
toc

