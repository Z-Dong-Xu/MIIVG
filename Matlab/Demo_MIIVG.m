clear ;
warning('off');
%%
Your_path = "E:\MY_FILES\VGNN";

name_1 = "\MIIVG\images\SH.jpg";
file_name = strcat(Your_path, name_1);

Image=imread(file_name);
Image = im2double(Image);
input = 0.3*Image(:,:,1)+0.5*Image(:,:,2)+0.2*Image(:,:,3);
input=histeq(input); 

%%
code = 0;
step = 1; % Because the conv2 function is used, so step must set to 1
MIIVG_0 = MIIVG_Scan(input, code, step);

%%
inputs = cell(1);
inputs{1} = input;
Patch_list = [0,95,235];
MIIVG_1 = MIIVG_Layer(inputs, Patch_list, step);
