% videoFrame = imread("check/10/1_1.jpg");
% imshow(videoFrame);
% zoom on;
% % Wait for the most recent key to become the return/enter key
% waitfor(gcf, 'CurrentCharacter', char(13))
% zoom reset
% zoom off
% Boxes = zeros(14,4);
% for k=1:14
%     %[x y w h]
%     [x1,y1] = ginput(1);
%     [x2,y2] = ginput(1);
%     [x3,y3] = ginput(1);
%     w = abs(x2 - x1);
%     h = abs(y3 - y1);
%     Boxes(k,:) = [x1, y1, w, h];
% end
% save('results/Boxes', 'Boxes');
% 
% load('Boxes');
% imshow(videoFrame);
% all_points = {};
% all_trackers = {};
% end_cell = 1;
% for k = 1:size(Boxes,1)
%     bbox = Boxes(k,:);
%     bboxPoints = bbox2points(bbox(1, :));
%     points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);
%     hold on;
%     color = [rand,rand,rand];
%     plot(points);
% 
%     pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
% 
%     % Initialize the tracker with the initial point locations and the initial
%     % video frame.
%     points = points.Location;
%     initialize(pointTracker, points, videoFrame);
%     all_points{end_cell} = points;
%     all_trackers{end_cell} = pointTracker;
%     end_cell = end_cell + 1;
% end
% save('results/videoFrame', 'all_points');
% save('results/all_trackers', 'all_trackers');

function mean_points = Tracker(videoFrame,n)
   load('results/all_points');
   load('results/all_trackers');
   colors = colorcube(n);
   colors = round(colors*255);
   mean_points = zeros(n,2);
   for k=1:length(all_points)
        oldPoints = all_points{k};
        pointTracker = all_trackers{k};
        
        [points, isFound] = step(pointTracker, videoFrame);
        visiblePoints = points(isFound, :);
        oldInliers = oldPoints(isFound, :);

        if size(visiblePoints, 1) >= 2 % need at least 2 points
            % Estimate the geometric transformation between the old points
            % and the new points and eliminate outliers
            [tform,oldInliers,visiblePoints] = estimateGeometricTransform(...
                oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);

            % Display tracked points
            videoFrame = insertMarker(videoFrame, visiblePoints, '+', ...
                'Color', colors(k,:));       

            % Reset the points
            oldPoints = visiblePoints;
            setPoints(pointTracker, oldPoints);        
            
            all_points{k} = points;
            all_trackers{k} = pointTracker;
            
            save('results/videoFrame', 'all_points');
            save('results/all_trackers', 'all_trackers');
            
            mean_points(k,:) = mean(points); 
            imshow(videoFrame);
        end
   end
end

    
    
    