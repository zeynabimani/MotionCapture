function dist = pointDist(point1,point2)
    dist = sqrt((point1(1,1)-point2(1,1)).^2 + (point1(1,2)-point2(1,2)).^2);           
end