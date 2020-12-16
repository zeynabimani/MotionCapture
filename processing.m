% %%default
% cam2.Exposure = -4;
% cam3.Exposure = -4;
% 
% %%very dark
% cam2.Exposure = 0;
% cam3.Exposure = 0;

counter = 1;
while true
    %%Acquire a single image.
    frame2 = snapshot(cam2);
    frame3 = snapshot(cam3);

    subplot(1,2,1), imshow(frame2)
    subplot(1,2,2), imshow(frame3)
    
%     path = 'calibration/' + string(counter);
%     imwrite(frame2,path + '_1.jpg');
%     imwrite(frame3,path + '_2.jpg');
%     counter = counter + 1;
    
    %Rpause for one second
    pause(1); 
end