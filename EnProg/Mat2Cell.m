function [ A ] = Mat2Cell(I,K,cc)
%UNTITLED Summary of this function goes here
%   for color image --->cc=3
%   for gray image  --->cc=1
[n,m]=size(I);
t=m/K;
w=n/cc;
for o=1:K
    for i=1:cc
    A{o}(1:w,1:t,i)=I((i-1)*w+1:i*w,(o-1)*t+1:o*t);
    end
    
end

end

