

for i=0:0
str1=['results/test_imgs/sequence5/start/data1_' num2str(i-1) '.mat'];

load('results/test_imgs/sequence5/start/data1_0.mat')
size(arr)

center1=zeros(25,2);
    b=1
    for n=1:3:75
    center1(b,1)=arr(1,n);
    center1(b,2)=arr(1,n+1);
    b=b+1;
    end
center1
save('center1')
str2=['results/test_imgs/sequence5/start/data2_' num2str(i-1) '.mat'];
load('results/test_imgs/sequence5/start/data2_0.mat')
% center2=zeros(25,2);
 w=1;
    for n=1:3:75
    center2(w,1)=arr(1,n);
    center2(w,2)=arr(1,n+1);
    w=w+1;
    end
center2
save('center2')
% load('results/calibrationSession6.mat');
% point3d = triangulate(center1,center2,calibrationSession.CameraParameters);
% point3d
end
 