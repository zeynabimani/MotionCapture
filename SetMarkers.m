function sortCnts = SetMarkers(videoFrame,N)
    figure
    imshow(videoFrame);
    zoom on;
    % Wait for the most recent key to become the return/enter key
    waitfor(gcf, 'CurrentCharacter', char(13))
    zoom reset
    zoom off
    sortCnts = zeros(N,2);
    for k=1:N
        [x1,y1] = ginput(1);
        sortCnts(k,:) = [x1, y1];
    end
    save('results/sortCnts', 'sortCnts');
end