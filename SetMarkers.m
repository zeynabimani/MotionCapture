function sortCnts = setMarkers(videoFrame,N, index)
    figure
    imshow(videoFrame);
    zoom on;
    % Wait for the most recent key to become the return/enter key
    waitfor(gcf, 'CurrentCharacter', char(13))
    zoom reset
    zoom off
    if index == 1
        sortCnts1 = zeros(N,2);
        for k=1:N
            [x1,y1] = ginput(1);
            sortCnts1(k,:) = [x1, y1];
        end
        sortCnts = sortCnts1;
        save('results/sortCnts1', 'sortCnts1');
    else
        sortCnts2 = zeros(N,2);
        for k=1:N
            [x1,y1] = ginput(1);
            sortCnts2(k,:) = [x1, y1];
        end
        save('results/sortCnts2', 'sortCnts2');
        sortCnts = sortCnts2;
    end
end