function [U,V] = DataLinked(ais,arpa,m,f)

d1=pdist2(ais(:,1:2),arpa(:,1:2));
u1=zeros(size(ais,1),size(arpa,1));
for i=1:size(ais,1)
    for j=1:size(arpa,1)
        if d1(i,j)==0
            u1(i,:)=0;
            u1(i,j)=1;
            break;
        elseif d1(i,j)>0
            u1(i,j)=1/( sum( (d1(i,j)./d1(i,:)).^(2/(m-1)) ) );
        end
    end
end

d2=pdist2(ais(:,3:4),arpa(:,3:4));
u2=zeros(size(ais,1),size(arpa,1));
for i=1:size(ais,1)
    for j=1:size(arpa,1)
        if d2(i,j)==0
            u2(i,:)=0;
            u2(i,j)=1;
            break;
        elseif d2(i,j)>0
            u2(i,j)=1/( sum( (d2(i,j)./d2(i,:)).^(2/(m-1)) ) );                  
        end
    end
end

a1=zeros(size(ais,1),size(arpa,1));
a2=zeros(size(ais,1),size(arpa,1));
for i=1:size(ais,1)
    for j=1:size(arpa,1)
        a1(i,j)=((1e-10)+sum(d1(i,:).^2)-d1(i,j)^2)/(2*(1e-10)+sum(d1(i,:).^2)+sum(d2(i,:).^2)-d1(i,j)^2-d2(i,j)^2);
        a2(i,j)=((1e-10)+sum(d2(i,:).^2)-d2(i,j)^2)/(2*(1e-10)+sum(d1(i,:).^2)+sum(d2(i,:).^2)-d1(i,j)^2-d2(i,j)^2);
    end
end

u=a1.*u1+a2.*u2;
U=nan*zeros(1,size(ais,1));
V=nan*zeros(1,size(arpa,1));
for i=1:size(ais,1)
    [arpaValue,apraIndex]=max(u(i,:));
    [aisValue,aisIndex]=max(u(:,apraIndex));
    if aisIndex==i && min(arpaValue,aisValue)>f
        U(i)=apraIndex;
        V(apraIndex)=i;
        u(i,:)=-inf;
        u(:,apraIndex)=-inf;
    elseif aisIndex~=i && min(arpaValue,aisValue)>f && arpaValue>aisValue
        U(i)=apraIndex;
        V(apraIndex)=i;
        u(i,:)=-inf;
        u(:,apraIndex)=-inf;
    elseif aisIndex~=i && min(arpaValue,aisValue)>f && arpaValue<aisValue
        U(aisIndex)=apraIndex;
        V(apraIndex)=aisIndex;
        u(aisIndex,:)=-inf;
        u(:,apraIndex)=-inf;
    end
end

