function matches = findMatches(center1, mean_points)
    matches = zeros(size(center1,1),1);
    for i = 1:size(center1,1)
        minDist = 9999;
        for j = 1:size(mean_points,1)
            dist = sqrt(abs(center1(i,1)-mean_points(j,1))^2 + abs(center1(i,2)-mean_points(j,2))^2);
            if dist < minDist
                matches(i) = j;
                minDist = dist;
            end
        end
    end
end