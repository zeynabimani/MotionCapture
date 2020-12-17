
load('calibrationSession.mat');
    I1=imread("C:\Users\almas\Desktop\moving5cm-990923\moving\vertical\1_1_20.jpg" );
    I2=imread("C:\Users\almas\Desktop\moving5cm-990923\moving\vertical\1_2_20.jpg");
   figure(1); imshowpair(I1, I2, 'montage'); 
    I1 = undistortImage(I1,calibrationSession.CameraParameters.CameraParameters1);
    I2 = undistortImage(I2,calibrationSession.CameraParameters.CameraParameters2);
%     figure;imshow(I2);

    [points1, points2] = markers(I1, I2,1,true);
    a = squeeze(points1(1,:,:));
    b=squeeze(points2(1,:,:));
    point3d = triangulate(a,b,calibrationSession.CameraParameters);
    distanceInMeters = norm(point3d)/1000;
    distanceAsString = sprintf('%0.2f meters', distanceInMeters);
    disp(distanceAsString);
    imshowpair(I1, I2, 'montage');
    disp(point3d(1,:));
   
   
 
   