clear ;
warning('off');

Your_path = "E:\MY_FILES\VGNN";

Patch_list = [0];
% Patch_list = [135];
step = 1;
Hist_num = 10;
Gaussian_level = 3;
Sampling_num = 1;
D = Gaussian_level*Hist_num*size(Patch_list, 2)*Sampling_num;

Feature_Mat = zeros(240 , D);
Label_Mat = zeros(240 , 1);

Name_cell = {'canvas1\canvas1', 'cushion1\cushion1', 'linseeds1\linseeds1',...
    'sand1\sand1', 'seat2\seat2', 'stone1\stone1'};
Name_num = size(Name_cell,2);


i = 1;
cost_time = 0;
tic
% t1=clock;
while i <= Name_num
    j = 1;
    while j <= 40
        name_1 = "\MIIVG\Texture_databases\Kylberg\";
        name_2 = Name_cell{i};
        if j <10
            name_3 = "-a-p00";
        else
            name_3 = "-a-p0";
        end
        name_4 = num2str(j);
        name_5 = ".png";
        file_name = strcat(Your_path, name_1,name_2,name_3,name_4,name_5);
        Image=imread(file_name);
        Image = im2double(Image);
        input=histeq(Image); 
        
        t1=clock;
        Res = MIIVG_Texture_Feature(input, Patch_list, step, Hist_num, Gaussian_level, Sampling_num);
        
        Feature_Mat( (i-1)*40+j , :) = Res(:);
        Label_Mat((i-1)*40+j , 1)  = i;
        
        t2=clock;
        cost_time = cost_time+etime(t2,t1);
        fprintf('ÒÑÍê³É£º Class:%d  Image:%d \n', i,j);
        
        j = j+1;
    end  
    i = i+1;
end
toc
% t2=clock;
% cost_time = etime(t2,t1);
time_per_sample = cost_time/size(Feature_Mat,1)

Feature_Mat(:,D+1) = Label_Mat(:);


