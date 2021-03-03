function SetMarkers(videoFrame,N)

    imshow(videoFrame);
    zoom on;
    % Wait for the most recent key to become the return/enter key
    waitfor(gcf, 'CurrentCharacter', char(13))
    zoom reset
    zoom off
    Centers = zeros(N,2);
    for k=1:N
        %[x y w h]
        [x1,y1] = ginput(1);
        Centers(k,:) = [x1, y1];
    end
    save('results/Centers', 'Centers');

    % load('Boxes');
    % imshow(videoFrame);
%     all_points = {};
%     all_trackers = {};
%     end_cell = 1;
%     for k = 1:size(Centers,1)
%          points = Centers(k,:);
% %         points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);
%         hold on;
%         plot(points);
% 
%         pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
% 
%         % Initialize the tracker with the initial point locations and the initial
%         % video frame.
%         points = points.Location;
%         initialize(pointTracker, points, videoFrame);
%         all_points{end_cell} = points;
%         all_trackers{end_cell} = pointTracker;
%         end_cell = end_cell + 1;
%     end
%     save('results/all_points', 'all_points');
%     save('results/all_trackers', 'all_trackers');

end