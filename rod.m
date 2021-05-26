
folder='results/test_imgs/rod/1m';  
myDir=dir(fullfile(folder,'*.jpg'));
k = 1;
points1 = zeros(2,2);
points2 = zeros(2,2);

for i=1:numel(myDir)
    fileName2=fullfile(folder,myDir(k).name);
    k = k+1;
    fileName3=fullfile(folder,myDir(k).name);
    k = k+1;
    if k > numel(myDir)
        break;
    end    
    frame2 = imread(fileName2);
    frame3 = imread(fileName3);
   
    figure
    imshow(frame2);
    zoom on;
    % Wait for the most recent key to become the return/enter key
    waitfor(gcf, 'CurrentCharacter', char(13))
    zoom reset
    zoom off
    for k=1:2
        [x1,y1] = ginput(1);
        points1(k,:) = [x1, y1];
    end
    close(gcf)
    figure
    imshow(frame3);
    zoom on;
    % Wait for the most recent key to become the return/enter key
    waitfor(gcf, 'CurrentCharacter', char(13))
    zoom reset
    zoom off
    for k=1:2
        [x1,y1] = ginput(1);
        points2(k,:) = [x1, y1];
    end
    close(gcf)
    point3d = reconstruct3d(frame2, frame3, points1, points2);   %%should be sorted
    distance=sqrt(((point3d(1,1)-point3d(2,1)).^2)+(((point3d(1,2)-point3d(2,2)).^2))+(((point3d(1,3)-point3d(2,3)).^2)));
    
end