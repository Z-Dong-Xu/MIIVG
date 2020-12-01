clear ;
warning('off');

Your_path = "E:\MY_FILES\VGNN";

Patch_list = [0,95,235];
step = 1;   % Because we use the conv2 function of MATLAB, So step must set to 1
Hist_num = 10;
Gaussian_level = 1;
Split_num = 1;
D = Gaussian_level*Hist_num*size(Patch_list, 2)*Split_num;

Class_num = 112;
% Image_NumPerClass = 20;
Sampling_num = 16;

Feature_Mat = zeros(Class_num*Sampling_num , D);
Label_Mat = zeros(Class_num*Sampling_num , 1);

i = 1;
cost_time = 0;
tic
% t1=clock;
while i <= Class_num    
    name_1 = "\MIIVG\Texture_databases\Original Brodatz\D";
    name_2 = num2str(i);
    name_3 = ".gif";
    file_name = strcat(Your_path, name_1,name_2,name_3);
    Origin_Image=imread(file_name);
    Origin_Image = im2double(Origin_Image);
    Origin_Image=histeq(Origin_Image);
    
    Sampling_Cell = Image_Sampling_1(Origin_Image, Sampling_num);
    
    t1=clock;
    j = 1;
    while j <= Sampling_num
        
        input=Sampling_Cell{j}; 
       
        Res = MIIVG_Texture_Feature(input, Patch_list, step, Hist_num, Gaussian_level, Split_num);
        
        Feature_Mat( (i-1)*Sampling_num+j , :) = Res(:);
        Label_Mat((i-1)*Sampling_num+j , 1)  = i;
        
        fprintf('ÒÑÍê³É£º Class:%d  Image:%d \n', i,j);
        
        j = j+1;
    end  
    t2=clock;
    cost_time = cost_time+etime(t2,t1);
    
    i = i+1;
end
toc
% t2=clock;
% cost_time = etime(t2,t1);
time_per_sample = cost_time/size(Feature_Mat,1)

Feature_Mat(:,D+1) = Label_Mat(:);

imagesc(Feature_Mat')








