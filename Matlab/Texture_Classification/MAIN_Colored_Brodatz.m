clear ;
warning('off');

Your_path = "E:\MY_FILES\VGNN";


Patch_list = [0,95,235];
step = 1;
Hist_num = 10;
Gaussian_level = 1;
Split_num = 1;

Class_num = 112;
% Image_NumPerClass = 20;
Sampling_num = 16;
Channel_num = 3;

D_sub = Gaussian_level*Hist_num*size(Patch_list, 2)*Split_num;

Feature_Mat = zeros(Class_num*Sampling_num , D_sub*Channel_num);
Label_Mat = zeros(Class_num*Sampling_num , 1);


i = 1;
cost_time = 0;
tic
% t1=clock;
while i <= Class_num    
    name_1 = "\MIIVG\Texture_databases\Colored Brodatz\D";
    name_2 = num2str(i);
    name_3 = "_COLORED.tif";
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
            
            Res = MIIVG_Texture_Feature(input, Patch_list, step, Hist_num, Gaussian_level,Split_num);
        
            
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

% Feature_Mat(:,361) = 0;
Feature_Mat(:,Channel_num*D_sub+1) = Label_Mat(:);
% imagesc(Feature_Mat')

% Repeat = 10;
% Accuracy = zeros(1,Repeat);
% i = 1;
% while i<=Repeat
%     [trainedClassifier, validationAccuracy] = trainClassifier_Color(Feature_Mat);
%     Accuracy(i) = validationAccuracy;
%     fprintf('已完成： Repeat:%d \n', i);
%     i = i+1;
% end
% AVE_Accuracy = sum(Accuracy)/Repeat














