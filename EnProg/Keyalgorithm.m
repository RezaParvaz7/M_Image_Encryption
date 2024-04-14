function [KEY] = Keyalgorithm( alpha,h,r,x0,I,X )
k=length(I);
[n,m,rr]=size(I{1});
S=n*m;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grayscale image
if rr==1
%========= step2
for i=1:k
AA=I{i};
for j=1:floor(n/2)
    A1(j,:)=bitxor(AA(j,:),AA(floor(n/2)+j,:));
end
 for j=1:floor(m/2)
    B1(:,j)=bitxor(A1(:,j),A1(:,floor(m/2)+j));
end   
 for j=1:floor(n/4)
    A2(j,:)=bitxor(B1(j,:),B1(floor(n/4)+j,:));
end
 for j=1:floor(m/4)
    B2(:,j)=bitxor(A2(:,j),A2(:,floor(m/4)+j));
 end
 
%======= step 3
A{i}=zeros(20,2);
A{i}(1,1)=mod(sum(sum(sum(B2(:,:,:))))/S,1);
end

A{1}(1,2)=mod(A{1}(1,1)+x0,1);
 for i=2:k
     A{i}(1,2)=mod(A{i}(1,1)+A{i-1}(1,2),1);
 end
 for i=1:k
    for j=2:20
     [A{i}(j,1),A{i}(j,2)]...
     =NDHChaos(alpha,h,r,A{i}(j-1,1),A{i}(j-1,2));
    end
 end
%==== step4 
AA=A{1}(1:20,:);
 for j=2:k
     AA=(AA+A{j}(1:20,:));
 end
%==== step5 
AA=circshift(AA,floor(AA(1,1)*100));
W(1,1:2)=mod(sum(AA(1:10,:))+X(1,1:2),1);
W(1,3:4)=mod(sum(AA(11:20,:))+X(1,3:4),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% color image
elseif rr==3
 for i=1:k 
AA=I{i};
%======= step 1
for j=1:floor(n/2)
    A1(j,:,:)=bitxor(AA(j,:,:),AA(floor(n/2)+j,:,:));
 end
 for j=1:floor(m/2)
    B1(:,j,:)=bitxor(A1(:,j,:),A1(:,floor(m/2)+j,:));
 end   
for j=1:floor(n/4)
    A2(j,:,:)=bitxor(A1(j,:,:),A1(floor(n/4)+j,:,:));
 end
for j=1:floor(m/4)
    B2(:,j,:)=bitxor(A2(:,j,:),A2(:,floor(m/4)+j,:));
  end  
%========= step3    
    A{i}=zeros(20,2);
    A{i}(1,1)=mod(sum(sum(sum(B2(:,:,:))))/S,1);
end
A{1}(1,2)=mod(A{1}(1,1)+x0,1);
 for i=2:k
     A{i}(1,2)=mod(A{i}(1,1)+A{i-1}(1,2),1);
 end
 for i=1:k
    for j=2:20
     [A{i}(j,1),A{i}(j,2)]...
     =NDHChaos(alpha,h,r,A{i}(j-1,1),A{i}(j-1,2));
    end
 end
%========step4
 AA=A{1}(1:20,:);
 for j=2:k
     AA=(AA+A{j}(1:20,:));
 end
%========= step5 
AA=circshift(AA,floor(AA(1,1)*100));
W(1,1:2)=mod(sum(AA(1:10,:))+X(1,1:2),1);
W(1,3:4)=mod(sum(AA(11:20,:))+X(1,3:4),1);      
end    
%====================================    
KEY=zeros(1,8);
KEY(1,1)=alpha;
KEY(1,2)=h;
KEY(1,3)=r;
KEY(1,4)=x0;
KEY(1,5:8)=W;

end

