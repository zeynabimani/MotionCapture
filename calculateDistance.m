function shortest = calculateDistance(center, lines, flags)
    dist = zeros(1,size(lines,1));
    for i=1:size(lines,1)
        if flags(i) == 0
            dist(i) = point_to_line_distance(center, lines(i,1:2), lines(i,3:4));
        else
            dist(i) = 999999;
        end
    end
   shortest = find(dist == min(dist));
   if size(shortest,2) > 1
       shortest = shortest(1)
   end
end