N = 14;
% frame2 = imread('results/first sequence/158_1.jpg');
% SetMarkers(frame2,N);
for i=160:171 
    path = 'results/first sequence/' + string(i);
    frame2 = imread(path + '_1.jpg');
    frame3 = imread(path + '_2.jpg');
    %get marker centers
    [BW1, BW2, center1, center2] = markers(frame2, frame3, N, true, i);
    %tracking
    mean_points = Tracker(frame2,N);
    matches = findMatches(center1, mean_points);
    center1=SortMatches(matches,center1);
    %find equivalent of each marker
    matches = epi2(BW1, BW2, center1, center2, i);
    %sorting
    center2=SortMatches(matches,center2);%% sorted algorithm
    %get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2, frame3, center1, center2); 
    draw(frame2, frame3, center1, center2, N, i);
end


