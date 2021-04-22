% %%default
% cam2.Exposure = -4;
% cam3.Exposure = -4;
% 
% %%very dark
% cam2.Exposure = 0;
% cam3.Exposure = 0;

counter = 1;
% 
% frame2 = imread("check/10/5_1.jpg");
% frame3 = imread("check/10/5_2.jpg");

while true 
   %%acquire a single image from webcams
    frame2 = snapshot(cam2);
    frame3 = snapshot(cam3);

    subplot(1,2,1), imshow(frame2)
    subplot(1,2,2), imshow(frame3)
    
    %saving images
    path = 'check/16/' + string(counter);
%     imwrite(frame2,path + '_1.jpg');
%     imwrite(frame3,path + '_2.jpg');
    
    time = datestr(now,'HH:MM:SS.FFF');
    time = strrep(time,':','-');
    time = strrep(time,'.','%');
    imwrite(frame2,path + '_' + time + '_1.jpg');
    imwrite(frame3,path + '_' + time + '_2.jpg');
    counter = counter + 1;
    
%     pause for one second
%     pause(1); 
end


