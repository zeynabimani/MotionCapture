% %%default
% cam2.Exposure = -4;
% cam3.Exposure = -4;
% 
% %%very dark
% cam2.Exposure = 0;
% cam3.Exposure = 0;

counter = 1;

frame2 = imread("check/test/43_1.jpg");
frame3 = imread("check/test/43_2.jpg");

% while true 
%    %%acquire a single image from webcams
%     frame2 = snapshot(cam2);
%     frame3 = snapshot(cam3);

%     subplot(1,2,1), imshow(frame2)
%     subplot(1,2,2), imshow(frame3)
%     
    %get marker centers
    [BW1, BW2, center1, center2] = markers(frame2, frame3, 14, true);
    %find equivalent of each marker
    maches = epi2(BW1, BW2, center1, center2, 28);
    %sorting
    center2=SortMatches(maches,center2);%% sorted algorithm
    %get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2, frame3, center1, center2);     
    
%     %saving images
%     path = 'check/10/' + string(counter);
%     imwrite(frame2,path + '_1.jpg');
%     imwrite(frame3,path + '_2.jpg');
%     counter = counter + 1;
    
%     pause for one second
%     pause(1); 
% end


