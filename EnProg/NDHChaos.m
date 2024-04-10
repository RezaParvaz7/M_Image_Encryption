function [ x2,y2 ] = NDHChaos(alpha,h,r,x1,y1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%----------------------
x12=newchaos2(h,alpha/2,r,x1);
y12=newchaos2(h,alpha/2,2*r,y1);

%----------------------
x22=newchaos2(h,alpha/10,r+((floor(y12*10)-floor(y12)*10)/10),x12);
y22=newchaos2(h,alpha/10,2*r+((floor(x12*10)-floor(x12)*10)/10),y12);

%=============  
x2=mod(x12+x22,1);
y2=mod(y12+y22,1);

end

