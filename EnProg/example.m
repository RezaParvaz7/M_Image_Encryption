clc
clear all
%======  COLOR Input Images
% I1=double(imread('4.1.01.tiff'));
% I2=double(imread('4.1.02.tiff'));
% I3=double(imread('4.1.05.tiff'));
% I4=double(imread('4.1.06.tiff'));
% I{1}=I1;I{2}=I2;I{3}=I3;I{4}=I4;
%============================
%======  Gray scale Input Images
I1=double(imread('lena.jpg'));
I2=double(imread('boat.512.tiff'));
I3=double(imread('4.2.07.tiff'));
I{1}=I1;I{2}=I2;I{3}=I3;
%=====================================
alpha=0.2;
h=0.01;
r=1.2;
x0=0.25;
XX=[0.2,0.3,0.7,0.8];
KEY = Keyalgorithm( alpha,h,r,x0,I,XX );
[EI,EKEY] = ENCRYPTION(I,KEY);
[WI] = DECRYPTION(EI,EKEY);
imshow(uint8(WI{2}))



