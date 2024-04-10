function [ D2] = InvPerm(D5,r,X,Y,a2,K,n,m,c)
s=reshape(Y',[1,2*a2]);
%================================
D5=Shiftproposed( D5',-floor(r*n*m*K/(sum(X(:))*10))...
     ,+10*floor(r*n*m*K/(sum(X(:))*10)) )';

 for j=1:c*n
     D5(j,:)=circshift(D5(j,:),-1*[1,((-1)^j)*mod(floor(s(j)*1000),K*m)]);
 end
 for i=1:K*m
     D5(:,i)=circshift(D5(:,i),-1*[((-1)^i)*mod(floor(s(i)*1000),c*n),1]);
 end
 D2=Shiftproposed( D5,-floor(c*n*m*K/(sum(X(:))*10))...
     ,+10*floor(c*n*m*K/(sum(X(:))*10)) );
end

