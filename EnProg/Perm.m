function [ D5] = Perm(I,r,X,Y,a2,K,n,m,c)
D2=Cell2Mat(I);
%++++++++++  Shift input Y
%----------  1 |--->
 D5=Shiftproposed( D2,floor(c*n*m*K/(sum(X(:))*10))...
     ,-10*floor(c*n*m*K/(sum(X(:))*10)) );
%----------  2  +-
 s=reshape(Y',[1,2*a2]);
 for i=1:K*m
     D5(:,i)=circshift(D5(:,i),[((-1)^i)*mod(floor(s(i)*1000),c*n),1]);
 end
 for j=1:c*n
     D5(j,:)=circshift(D5(j,:),[1,((-1)^j)*mod(floor(s(j)*1000),K*m)]);
 end
%--------  3 
 D5=Shiftproposed( D5',floor(r*n*m*K/(sum(X(:))*10))...
     ,-10*floor(r*n*m*K/(sum(X(:))*10)) )';
end

