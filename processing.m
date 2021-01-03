% %%default
% cam2.Exposure = -4;
% cam3.Exposure = -4;
% 
% %%very dark
% cam2.Exposure = 0;
% cam3.Exposure = 0;

%counter = 1;

% frame2 = imread("75_1.jpg");
% frame3 = imread("75_2.jpg");

% while true
%    %%acquire a single image from webcams
%     frame2 = snapshot(cam2);
%     frame3 = snapshot(cam3);

   sum=0;
   A=zeros(1,24);
    for i=1:24
       path="C:/Users/almas/Documents/test/2/20/";
       frame2=imread(path+int2str(i)+"_1.jpg");
       frame3=imread(path+int2str(i)+"_2.jpg");
        subplot(1,2,1), imshow(frame2)
        subplot(1,2,2), imshow(frame3)
   

     
    
   
    
    %%get marker centers
    [BW1, BW2, center1, center2] = markers(frame2,frame3, 2, false);
    %%find equivalent of each marker
    maches = epi2(BW1, BW2, center1, center2);
     disp(i);
     disp(maches);
   
    center2=SortMatches(maches,center2);%% sorted algorithm
    %%get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2,frame3, center1, center2);   %%should be sorted
    distance=sqrt(((point3d(1,1)-point3d(2,1)).^2)+(((point3d(1,2)-point3d(2,2)).^2))+(((point3d(1,3)-point3d(2,3)).^2)));
    disp(distance);
    sum=(sum+(distance*0.10));
    A(i)=(distance*0.10);
    if i==1
         fid = fopen('F:\MotionCapture\result.txt','w');
%          fprintf(fid,'%s\n%s\n%s\n%s\n%s\n',"Frame"+int2str(i),"center1  "+center1, "center2  "+center2,"distance    "+distance,"-------------------------------------------------------------------------------------------------");
          fprintf(fid,'%s\n%s\n%s\n',"Frame"+int2str(i),"distance    "+distance*0.10+"cm","-------------------------------------------------------------------------------------------------");
         fclose(fid);
 
    else 
       fid = fopen('F:\MotionCapture\result.txt','a');
%        fprintf(fid,'%s\n%s\n%s\n%s\n%s\n',"Frame"+int2str(i),"center1  "+center1, "center2  "+center2,"distance    "+distance,"-------------------------------------------------------------------------------------------------");
       fprintf(fid,'%s\n%s\n%s\n',"Frame"+int2str(i),"distance    "+distance*0.10+"cm","-------------------------------------------------------------------------------------------------");
       fclose(fid);
    end
   
    end
    average=(sum./24);
    variance=var(A);
     fid = fopen('F:\MotionCapture\result1.txt','w');
%        fprintf(fid,'%s\n%s\n%s\n%s\n%s\n',"Frame"+int2str(i),"center1  "+center1, "center2  "+center2,"distance    "+distance,"-------------------------------------------------------------------------------------------------");
     fprintf(fid,'%s\n%s\n%s\n',"Average   "+average,"Variance    "+variance,"Num    "+int2str(24));
     fclose(fid);
    
   
    
    
%     %%saving images
%     path = 'calibration/' + string(counter);
%     imwrite(frame2,path + '_1.jpg');
%     imwrite(frame3,path + '_2.jpg');
%     counter = counter + 1;
    
    %pause for one second
%     pause(1); 
% end


