function matches = findMatches(center1, mean_points)  %sort unsort
    matches = zeros(size(center1,1),1);
    flags = zeros(size(center1,1),1);
    for i = 1:size(center1,1)
        minDist = 9999;
        for j = 1:size(mean_points,1)
            if flags(j) == 0
                dist = pointDist(center1(i,:),mean_points(j,:));
                if dist < minDist
                    matches(i) = j;
                    minDist = dist;
                end
            end
        end
        flags(matches(i)) = 1;
    end
end