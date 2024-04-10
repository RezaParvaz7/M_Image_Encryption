function [ x1] = newchaos2(h,alpha,r,x0 )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
B=1-alpha+(alpha/gamma(alpha));
x1=((1-alpha)+((h^(alpha))/(gamma(alpha))))*(1/B)*chaosc2(r, x0 );
end