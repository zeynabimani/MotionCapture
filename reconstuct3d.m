function point3d = reconstruct3d(I1, I2)
    I1 = undistortImage(I1,calibrationSession.CameraParameters.CameraParameters1);
    I2 = undistortImage(I2,calibrationSession.CameraParameters.CameraParameters2);

    [center1, center2] = markers(I1, I2,1,true);
    point3d = triangulate(center1,center2,calibrationSession.CameraParameters);
    distanceInMeters = norm(point3d)/1000;
    distanceAsString = sprintf('%0.2f meters', distanceInMeters);
    disp(distanceAsString);
    disp(point3d(1,:));
end
 
   