function dist = calculateDistance(center, lines)
    dist = zeros(1,size(lines,1));
    for i=1:size(lines,1)
       dist(i) = point_to_line_distance(center, lines(i,1:2), lines(i,3:4));
    end
end