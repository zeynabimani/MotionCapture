N = 14;
%  frame2 = imread('results/first sequence/158_1.jpg');
%  SetMarkers(frame2,N);
sw=1;
t2=1;
t1=0;
center_prev=zeros(14,2);
folder='results/first sequence/New/';  
I=dir(fullfile(folder,'*.jpg'));
 arr2=strings([numel(I),3]);
for k=1:numel(I)
  filename=fullfile(folder,I(k).name);
 
  I2{k}=imread(filename);
 arr2(k,:)=split(I(k).name,'_');
 
  
end

% sortrows(arr',1)
for i=1:2:length(arr)
    path1 = 'results/first sequence/New' + string(arr(i));
    path2 = 'results/first sequence/New' + string(arr(i+1));
    frame2 = imread(path1);
    frame3 = imread(path2);
   
    %get marker centers
    colors = hsv(N);
    [BW1, BW2, center1, center2] = markers(frame2, frame3, colors, N, true, arr(i,1));
    
    if(all(center_prev(:)==0))
     center_prev= center1;    
    [BWt21, BWt22, center1t2, center2t2] = markers(frame2, frame3, colors, N, true,arr(i+2,1));
     center1 =center1t2;
     
    end 
    if(sw==1)
        disp("kk");
    %SetMarkers(frame2,N);
    center_prev=SortCenter1(center_prev);
    sw=3;
    else
        disp("klll");
        if(sw==2)
            [bvalue,centerNew]=TrackerNew(center_prev,center1,v,t2,t1,colors,N,arr(i,1),BW1);
%             disp(centerNew);
             
            if(bvalue==False)
                sw=3;
            else
               center1=centerNew;
            end
            
            
        end
        if(sw==3)
            [v,center1]=CalculateV(center_prev,center1,t1,t2);
            sw=2;
           
        end
     center_prev=center1; 
    end

    videoFrame = frame2;
    for k=1:N   
        videoFrame = insertMarker(videoFrame, center1(k,:), '+', 'Color', round(colors(k,:)*255));
    end
    imwrite(videoFrame,string("res/" + arr(i,1) + "_3.jpg"));
    %find equivalent of each marker
    matches = epi2(BW1, BW2, center1, center2, colors, N, arr(i,1));
    %sorting
    center2=SortMatches(matches,center2);%% sorted algorithm
    %get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2, frame3, center1, center2); 
    ExcelWriter(point3d);
    
    draw(frame2, frame3, center1, center2, colors, arr(i,1));
end


