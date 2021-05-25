load('data1.mat')
center1=zeros(25,2);
b=1
for n=1:3:75
    center1(b,1)=arr(1,n);
    center1(b,2)=arr(1,n+1);
    b=b+1;
end
save('center1')

load('data2.mat')
center2=zeros(25,2);
b=1
for n=1:3:75
    center2(b,1)=arr(1,n);
    center2(b,2)=arr(1,n+1);
    b=b+1;
end
save('center2')