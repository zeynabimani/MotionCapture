function point3d = reconstruct3d(I1, I2, center1, center2)
    load('results/calibrationSession6.mat');
    length(center1)
    length(center2)
    point3d = triangulate(center1,center2,calibrationSession.CameraParameters);
end
 
   