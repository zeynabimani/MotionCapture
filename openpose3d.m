

for i=1:22
str1=['matfiles/center1/data1_' num2str(i-1) '.mat'];

load(str1)
size(arr)
if i==1
 for o=1:3:75
    
    
   figure(1)
   plot(arr(1,o),arr(1,o+1),'o')
   hold on
 end
end
% center1=zeros(75,2);
% for n=1:75
%   for m=1:2
% center1(n,m)=arr(1,2);
%   end
% end

% str2=['matfiles/center2/data2_' num2str(i-1) '.mat'];
% load(str2)
% center2=arr;
% load('results/calibrationSession6.mat');
% point3d = triangulate(center1,center2,calibrationSession.CameraParameters);
% point3d
end
 