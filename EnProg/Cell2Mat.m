function [ A ] = Cell2Mat(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[n,m,c]=size(I{1});
K=length(I);
A=zeros(c*n,K*m);
 for i=1:K
     for j=1:c
         A((j-1)*n+1:j*n,(i-1)*m+1:i*m)=I{i}(:,:,j); 
     end
 end

end

