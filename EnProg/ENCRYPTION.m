function [EI,EKEY] = ENCRYPTION(I,KEY)
%=========== Key step
K=length(I);
[n,m,c]=size(I{1});
alpha=KEY(1,1);
h=KEY(1,2);
r=KEY(1,3);
x0=KEY(1,4);
X0=KEY(1,5:8);
%============ step 1-7
K=length(I);
[n,m,c]=size(I{1});
X(1,:)=X0(1,1:2);
a1=floor((K)/2)+1;
a2=floor(max(c*n/2,K*m/2));

for i=1:a1
    [X(i+1,1) X(i+1,2)]=...
        NDHChaos(alpha,h,r,X(i,1),X(i,2));
end
Y(1,:)=X0(1,3:4);
for i=1:a2-1
    [Y(i+1,1) Y(i+1,2)]=...
        NDHChaos(alpha,h,r,Y(i,1),Y(i,2));
end
[D5] = Perm(I,r,X,Y,a2,K,n,m,c);
%============ step 8-9
[EI1] = Def(D5, alpha,h,r,X,Y,a1,a2,K,n,m,c );
%============= step 10
Cr=double(Cell2Mat(EI1));
[nn,mm]=size(Cr);
sp=sum(sum(Cr))/(nn*mm*255);
ap=abs(floor(sp*10^(15))-floor(sp*10^(10))*10^(5))/100000;
EKEY=zeros(1,9);
EKEY(1,1:8)=KEY;
EKEY(1,9)=ap;
ZX(1,:)=X0(1,1:2)+[ap,ap];
for i=1:a1
    [ZX(i+1,1) ZX(i+1,2)]=...
        NDHChaos(alpha+ap,h,r+ap,ZX(i,1),ZX(i,2));
end
ZY(1,:)=[ZX(a1,1),ZX(a1,2)];
for i=1:a2-1
    [ZY(i+1,1) ZY(i+1,2)]=...
        NDHChaos(alpha+ap,h,r+ap,ZY(i,1),ZY(i,2));
end
D5= Perm(EI1,r+ap,ZX,ZY,a2,K,n,m,c);

EI=Mat2Cell(uint8(D5),K,c);



end

