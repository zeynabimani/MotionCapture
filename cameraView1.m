N = 14;
sw = 1;
t_now = 0;
t_prev = 0;
k = 1;
center_prev=zeros(14,2);
folder='results/test_imgs/sequence2/';  
myDir=dir(fullfile(folder,'*.jpg'));d
for i=1:numel(myDir)
    
    fileName2=fullfile(folder,myDir(k).name);
    k = k+1;
    fileName3=fullfile(folder,myDir(k).name);
    k = k+1;
    
    name = [];
    name = split(fileName3,'\'); 
    name = split(string(name(size(name,1),1)),'_'); 
    t_now = str2double(name(2,1));
    
    frame2 = imread(fileName2);
    frame3 = imread(fileName3);

    %get marker centers
    colors = hsv(N);
    [BW1, BW2, center1, center2] = markers(frame2, frame3, colors, N, true, name(1,1));
    
    if sw == 1 
%         sortCnts = SetMarkers(frame2,N);
        load('results/sortCnts');
        center1 = sortCenter(center1,sortCnts);
        sw = 3;
    else
        if sw == 2 
            [bvalue,centerNew]=TrackerNew(center_prev, center1, v, t_prev, t_now, colors, N, name(1,1), BW1);
            if(bvalue==false)
                sw = 3;
            else
               center1 = centerNew;
            end
        end
        if sw == 3 
            [v,center1] = CalculateV(center_prev, center1, t_prev, t_now, BW1, N, colors, name(1,1));
            sw=2;
        end
    end
    %find equivalent of each marker
    matches = epi2(BW1, BW2, center1, center2, colors, N, i);
    %sorting
    center2=SortMatches(matches,center2);%% sorted algorithm
    %get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2, frame3, center1, center2); 
%     ExcelWriter(point3d);
    draw(frame2, frame3, center1, center2, colors, name(1,1));
    
    t_prev = t_now;
    center_prev = center1;
end


