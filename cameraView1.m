
counter = 1;

while true
   %%acquire a single image from webcams
    frame2 = snapshot(cam2);
    path1 = "check/5/" + string(counter) + datestr(now,'_HH-MM-SS-FFF') + '_1.jpg';
    frame3 = snapshot(cam3);
    path2 = "check/5/" + string(counter) + datestr(now,'_HH-MM-SS-FFF') + '_2.jpg';
    
    subplot(1,2,1), imshow(frame2)
    subplot(1,2,2), imshow(frame3)

    %%saving images
    imwrite(frame2,path1);
    imwrite(frame3,path2);
    counter = counter + 1;
    
%     pause for one second
%     pause(1); 
end


