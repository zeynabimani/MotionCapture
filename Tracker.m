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
            
            save('results/all_points', 'all_points');
            save('results/all_trackers', 'all_trackers');
            
            mean_points(k,:) = mean(points); 
            imshow(videoFrame);
        end
   end
end

    
    
    