function SetMarkers(videoFrame,N)

    imshow(videoFrame);
    zoom on;
    % Wait for the most recent key to become the return/enter key
    waitfor(gcf, 'CurrentCharacter', char(13))
    zoom reset
    zoom off
    Boxes = zeros(N,4);
    for k=1:N
        %[x y w h]
        [x1,y1] = ginput(1);
        [x2,y2] = ginput(1);
        [x3,y3] = ginput(1);
        w = abs(x2 - x1);
        h = abs(y3 - y1);
        Boxes(k,:) = [x1, y1, w, h];
    end
    save('results/Boxes', 'Boxes');

    % load('Boxes');
    % imshow(videoFrame);
    all_points = {};
    all_trackers = {};
    end_cell = 1;
    for k = 1:size(Boxes,1)
        bbox = Boxes(k,:);
        points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);
        hold on;
        plot(points);

        pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

        % Initialize the tracker with the initial point locations and the initial
        % video frame.
        points = points.Location;
        initialize(pointTracker, points, videoFrame);
        all_points{end_cell} = points;
        all_trackers{end_cell} = pointTracker;
        end_cell = end_cell + 1;
    end
    save('results/all_points', 'all_points');
    save('results/all_trackers', 'all_trackers');

end