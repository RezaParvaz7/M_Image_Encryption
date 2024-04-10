function [I] = DECRYPTION(EI,EKEY)
K=length(EI);
[n,m,c]=size(EI{1});
alpha=EKEY(1,1);
h=EKEY(1,2);
r=EKEY(1,3);
X0=EKEY(1,5:8);
ap=EKEY(1,9);
a1=floor((K)/2)+1;
a2=floor(max(c*n/2,K*m/2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%============= step 10
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
WZD5=Cell2Mat(EI);
WD2=InvPerm(WZD5,r+ap,ZX,ZY,a2,K,n,m,c);
WEI1=Mat2Cell(WD2,K,c);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X(1,:)=X0(1,1:2);
for i=1:a1
    [X(i+1,1) X(i+1,2)]=...
        NDHChaos(alpha,h,r,X(i,1),X(i,2));
end
Y(1,:)=X0(1,3:4);
for i=1:a2-1
    [Y(i+1,1) Y(i+1,2)]=...
        NDHChaos(alpha,h,r,Y(i,1),Y(i,2));
end
%-----------
WD5 = InvDef(WEI1, alpha,h,r,X,Y,a1,a2,K,n,m,c );
%-----------
WI = InvPerm(WD5,r,X,Y,a2,K,n,m,c);
I=Mat2Cell(WI,K,c);
end

