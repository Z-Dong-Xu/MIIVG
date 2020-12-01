function [imgn] = HomoTrans_Img(Image,H)
%HomoTrans_Img �˴���ʾ�йش˺�����ժҪ
%   �˱任������Ϊ�������꣬��x���������£�y����������

%% ���û�����
[h,w]=size(Image);    %����yΪ�任��ͼ��ĸ߶ȣ�xΪ�任��ͼ��Ŀ��
% rot �����ǵ�Ӧ�Ծ���H��ת��
rot = H';
pix1=[1 1 1]*rot;               %�任��ͼ�����ϵ������
pix2=[1 w 1]*rot;               %�任��ͼ�����ϵ������
pix3=[h 1 1]*rot;               %�任��ͼ�����µ������
pix4=[h w 1]*rot;               %�任��ͼ�����µ������

height=round(max([abs(pix1(1)-pix4(1))+0.5 abs(pix2(1)-pix3(1))+0.5]));     %�任��ͼ��ĸ߶�
width=round(max([abs(pix1(2)-pix4(2))+0.5 abs(pix2(2)-pix3(2))+0.5]));      %�任��ͼ��Ŀ��
imgn=zeros(height,width);

delta_y=abs(min([pix1(1) pix2(1) pix3(1) pix4(1)]));            %ȡ��y����ĸ��ᳬ����ƫ����
delta_x=abs(min([pix1(2) pix2(2) pix3(2) pix4(2)]));            %ȡ��x����ĸ��ᳬ����ƫ����

imgm=Extend_img(Image,1);     %��չ�߽�õ���ͼ��

%% ��ӳ���ÿ�����ص�����ӳ�䵽ԭʼͼ���У�������˫���Բ�ֵ����
% INV_rot = inv(rot);
for i=1-delta_y:height-delta_y
    for j=1-delta_x:width-delta_x
        pix=[i j 1]/rot;                                %�ñ任��ͼ��ĵ������ȥѰ��ԭͼ�������꣬                                         
                                                            %������Щ�任���ͼ������ص��޷���ȫ���
        float_Y=pix(1)-floor(pix(1)); 
        float_X=pix(2)-floor(pix(2));    
       
        if pix(1)>=-1 && pix(2)>=-1 && pix(1) <= h+1 && pix(2) <= w+1     
            
            pix_up_left=[floor(pix(1)) floor(pix(2))];          %�ĸ����ڵĵ�
            pix_up_right=[floor(pix(1)) ceil(pix(2))];
            pix_down_left=[ceil(pix(1)) floor(pix(2))];
            pix_down_right=[ceil(pix(1)) ceil(pix(2))]; 
        
            value_up_left=(1-float_X)*(1-float_Y);              %�����ٽ��ĸ����Ȩ��
            value_up_right=float_X*(1-float_Y);
            value_down_left=(1-float_X)*float_Y;
            value_down_right=float_X*float_Y;
                                                            
            imgn(i+delta_y,j+delta_x)=value_up_left*imgm(pix_up_left(1)+2,pix_up_left(2)+2)+ ...
                                        value_up_right*imgm(pix_up_right(1)+2,pix_up_right(2)+2)+ ...
                                        value_down_left*imgm(pix_down_left(1)+2,pix_down_left(2)+2)+ ...
                                        value_down_right*imgm(pix_down_right(1)+2,pix_down_right(2)+2);
        end       
        
    end
end

end

