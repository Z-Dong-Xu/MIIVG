function [] = GreenLine_plot(input_1,input_2,Index_list_1, Index_list_2, Match_list)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
Size_img_1 = size(input_1);
Size_img_2 = size(input_2);
height = max( Size_img_1(1), Size_img_2(1) );
width = Size_img_1(2) + Size_img_2(2);
Big_img = zeros(height, width);
Big_img(1: Size_img_1(1) , 1: Size_img_1(2) ) = input_1(:, :);
Big_img(1: Size_img_2(1) , Size_img_1(2)+1: width) = input_2(:, :);


MatIndex_X_1 = Index_list_1(:,1);
MatIndex_Y_1 = Index_list_1(:,2);
MatIndex_X_2 = Index_list_2(:,1);
MatIndex_Y_2 = Index_list_2(:,2) + Size_img_1(2);

imshow(Big_img);hold on
scatter(MatIndex_Y_1,MatIndex_X_1,'r+')
scatter(MatIndex_Y_2,MatIndex_X_2,'r+')

KeyMatch_num = min( size(Index_list_1,1), size(Index_list_2,1) );
i = 1;
while i <= KeyMatch_num
    fitness = -Match_list(i,3);
    if fitness <= 30000 %%%%%%%%%%%%
        line([MatIndex_Y_1(i),MatIndex_Y_2(i)],[MatIndex_X_1(i),MatIndex_X_2(i)],...
            'linestyle','-','color','g');
    end
    i = i+1;
end
    
end

