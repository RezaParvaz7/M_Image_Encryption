function [ A ] = Shiftproposed( I,a,b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(I);
D21=zeros(floor(n/2),m);
D22=D21;
for i=1:floor(n/2)
D21(i,:)=I(2*i,:);
D22(i,:)=I(2*i-1,:);
end

D31=reshape(D21',[1,floor(n/2)*m]);
D31=circshift(D31, [1,a]);
D51=reshape(D31,[m,floor(n/2)])';

D32=reshape(D22',[1,floor(n/2)*m]);
D32=circshift(D32, [1,b]);
D52=reshape(D32,[m,floor(n/2)])';

A=zeros(n,m);
for i=1:floor(n/2)
A(2*i,:)=D51(i,:);
A(2*i-1,:)=D52(i,:);
end
