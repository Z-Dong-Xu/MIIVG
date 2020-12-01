clear ;
warning('off');

Your_path = "E:\MY_FILES\VGNN";

Patch_list = [0,95,235];
% Patch_list = [32];
% Patch_list = [1,2,4,8,16,32,64,128];
step = 1;
Hist_num = 10;
Split_num = 1;
Gaussian_level = 1;
D_sub = Gaussian_level*Hist_num*size(Patch_list, 2)*Split_num;


Class_num = 154;
% Image_NumPerClass = 20;
Sampling_num = 16;
Channel_num = 3;


Feature_Mat = zeros(Class_num*Sampling_num , D_sub*Channel_num);
Label_Mat = zeros(Class_num*Sampling_num , 1);


cost_time = 0;
i = 1;
tic
% t1=clock;
while i <= Class_num    
    name_1 = "\MIIVG\Texture_databases\Multi_band_Texture\Dz";
    name_2 = num2str(i);
    name_3 = ".tif";
    file_name = strcat(Your_path, name_1,name_2,name_3);
    Origin_Image=imread(file_name);
    Origin_Image = im2double(Origin_Image);
    Origin_Image=histeq(Origin_Image);
    
%     R_image = Origin_Image(:, :, 1);
%     G_image = Origin_Image(:, :, 2);
%     B_image = Origin_Image(:, :, 3);
    
    t1=clock;
    c = 1;
    while c<=3
        Sampling_Cell = Image_Sampling_1(Origin_Image(:, :, c), Sampling_num);
        
        j = 1;
        while j <= Sampling_num

            input=Sampling_Cell{j}; 
            
            Res = MIIVG_Texture_Feature(input, Patch_list, step, Hist_num, Gaussian_level, Split_num);
            
            
            Feature_Mat( (i-1)*Sampling_num+j , (c-1)*D_sub + 1:  c*D_sub) = Res(:);
            Label_Mat((i-1)*Sampling_num+j , 1)  = i;
            fprintf('已完成： Class:%d  Channel:%d  Image:%d \n', i,c,j);

            j = j+1;
        end       
        c = c+1; 
    end
    t2=clock;
    cost_time = cost_time+etime(t2,t1);
    
    i = i+1;
end
toc
% t2=clock;
% cost_time = etime(t2,t1);
time_per_sample = cost_time/size(Feature_Mat,1)

Feature_Mat(:,D_sub*Channel_num+1) = Label_Mat(:);

% Repeat = 10;
% Accuracy = zeros(1,Repeat);
% i = 1;
% while i<=Repeat
%     [trainedClassifier, validationAccuracy] = trainClassifier(Feature_Mat);
%     Accuracy(i) = validationAccuracy;
%     fprintf('已完成： Repeat:%d \n', i);
%     i = i+1;
% end
% AVE_Accuracy = sum(Accuracy)/Repeat
% name_1 = "E:\MY_FILES\VGNN\MATLAB_prog\Texture_Classification\Variable\MBT_Feature_Label_";
% name_2 = num2str(size(Patch_list, 2));
% name_3 = "_";
% name_4 = num2str(step);
% name_5 = "_";
% name_6 = num2str(Hist_num);
% name_7 = "_";
% name_8 = num2str(Split_num);
% name_9 = "_";
% name_10 = num2str(Gaussian_level);
% name_11 = ".mat";
% file_name = strcat(name_1,name_2,name_3,name_4,name_5,name_6,name_7,name_8,name_9,...
%     name_10,name_11);
% 
% save(file_name,'Feature_Mat')
% imagesc(Feature_Mat')
















