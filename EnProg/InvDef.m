function [DD] = InvDef(EI, alpha,h,r,X,Y,a1,a2,K,n,m,c )

%=======================================
Y2(1,:)=[X(a1,1),Y(a2,2)];
for i=1:n*m-1
  [Y2(i+1,1) Y2(i+1,2)]=...
       NDHChaos(alpha,h,r,Y2(i,1),Y2(i,2));     
end
A1a=reshape(Y2(:,1),[n,m]);
A2a=reshape(Y2(:,2),[n,m]);

if c==1
A1=uint8(A1a*255);
A2=uint8(A2a*255);
for i=1:K
   EI1{i}=bitxor(bitxor(uint8(EI{i}),A2),A1);
end
elseif c==3
A1(:,:,1)=uint8(A1a*255);
A1(:,:,2)=uint8(A2a*255);
A1(:,:,3)=uint8(A1a*255);
%A=Mat2Cell(uint8(D5),K,3);
for i=1:K
   EI1{i}=bitxor(uint8(EI{i}),A1);
end
end     
    
%++++++++++++++++++++++++++++++++++
Yt2(1,:)=[X(a1,1),Y(a2,2)];
nt1=floor(n/2);
mt1=floor(m/2);
for i=1:(nt1/2)*mt1-1
  [Yt2(i+1,1) Yt2(i+1,2)]=...
       NDHChaos(2*alpha,h,2*r,Yt2(i,1),Yt2(i,2));     
end
At1=reshape(Yt2(:,1),[nt1/2,mt1]);
At2=reshape(Yt2(:,2),[nt1/2,mt1]);
At(1:nt1/2,1:mt1)=At1;
At((nt1/2)+1:nt1,1:mt1)=At2;

AAt(1:nt1,1:mt1)=At;
AAt(1:nt1,mt1+1:m)=At;
AAt(nt1+1:n,1:mt1)=At;
AAt(nt1+1:n,mt1+1:m)=At;
if c==1
CAAt=uint8(AAt*255);
elseif c==3
for i=1:c
    CAAt(:,:,i)=uint8(AAt*255);
end   
end  

for i=1:K
  A{i}=bitxor(EI1{i},CAAt);
end



DD= Cell2Mat(A);
%==================================================
end

