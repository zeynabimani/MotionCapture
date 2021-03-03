N = 14;
%  frame2 = imread('results/first sequence/158_1.jpg');
%  SetMarkers(frame2,N);
sw=1;
t2=1;
t1=0;
center_prev=double.empty(14,2);
for i=158:161
    path = 'results/first sequence/' + string(i);
    frame2 = imread(path + '_1.jpg');
    frame3 = imread(path + '_2.jpg');
   
    %get marker centers
    colors = hsv(N);
    [BW1, BW2, center1, center2] = markers(frame2, frame3, colors, N, true, i);
    if(isempty(center_prev))
     center_prev= center1;
    [BW21, BW22, center21, center22] = markers(frame2, frame3, colors, N, true, i+1);
     center1 =center21;
    end
    
    %tracking
    if(sw==1)
    %SetMarkers(frame2,N);
    center_prev=SortCenter1(center_prev);
    sw=3;
    else
        if(sw==2)
            [bvalue,centerNew]=TrackerNew(center_prev,center1,v,t2,t1,colors,N,i);
            if(bvalue==False)
                sw=3;
            else
               center1=centerNew;
            end
            
            
        end
        if(sw==3)
            v=CalculateV(center_prev,center1,t1,t2);
            sw=2;
        end
     center_prev=center1; 
    end
    mean_points = Tracker(center1,center21,t, colors, N, i);
    matches = findMatches(center1, mean_points);
    center1=SortMatches(matches,center1);
    videoFrame = frame2;
    for k=1:N   
        videoFrame = insertMarker(videoFrame, center1(k,:), '+', 'Color', round(colors(k,:)*255));
    end
    imwrite(videoFrame,string("res/" + string(i) + "_3.jpg"));
    %find equivalent of each marker
    matches = epi2(BW1, BW2, center1, center2, colors, N, i);
    %sorting
    center2=SortMatches(matches,center2);%% sorted algorithm
    %get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2, frame3, center1, center2); 
    ExcelWriter(point3d);
    
    draw(frame2, frame3, center1, center2, colors, i);
end


