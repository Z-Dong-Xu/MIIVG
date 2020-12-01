function imgm=Extend_img(img,r)
%%%
%   用于HomoTrans_Img调用，防止bug的，加入之后可以防止90度180度的bug
%%%
    [m,n]=size(img);

    imgm=zeros(m+2*r+1,n+2*r+1);

    imgm(r+1:m+r,r+1:n+r)=img;
    imgm(1:r,r+1:n+r)=img(1:r,1:n); 
    imgm(1:m+r,n+r+1:n+2*r+1)=imgm(1:m+r,n:n+r);
    imgm(m+r+1:m+2*r+1,r+1:n+2*r+1)=imgm(m:m+r,r+1:n+2*r+1);
    imgm(1:m+2*r+1,1:r)=imgm(1:m+2*r+1,r+1:2*r);

end

