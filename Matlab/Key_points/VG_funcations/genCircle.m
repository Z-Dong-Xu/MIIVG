function [ c ] = genCircle(w,r)
%GENCIRCLE Summary of this function goes here
%   Detailed explanation goes here
%   w ��ģ��Ĵ�С
%   r Բ��ģ��İ뾶
[rr,cc] = meshgrid(1:w);
c = sqrt( (rr-floor(w/2)-1).^2 + (cc-floor(w/2)-1).^2 ) <= r;
end

