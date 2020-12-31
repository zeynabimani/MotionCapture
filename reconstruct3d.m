function point3d = reconstruct3d(I1, I2, center1, center2)
    load('F:/MotionCapture/results/calibrationSession.mat');
    I1 = undistortImage(I1,calibrationSession.CameraParameters.CameraParameters1);
    I2 = undistortImage(I2,calibrationSession.CameraParameters.CameraParameters2);
    point3d = triangulate(center1,center2,calibrationSession.CameraParameters);
    disp(point3d);
end
 
   