N = 11;
sw = 1;
t_now = 0;
t_prev = 0;
k = 1;
center1_prev=zeros(N,2);
center2_prev=zeros(N,2);
folder='results/test_imgs/sequence3/';  
myDir=dir(fullfile(folder,'*.jpg'));
show = false;
for i=1:numel(myDir)
    
    fileName2=fullfile(folder,myDir(k).name);
    k = k+1;
    fileName3=fullfile(folder,myDir(k).name);
    k = k+1;
    
    name = [];
    name = split(fileName3,'\'); 
    name = split(string(name(size(name,1),1)),'_'); 
    t_now = name(2,1);
    t_now = strrep(t_now,'-',':');
    t_now = strrep(t_now,'%','.');
    
    frame2 = imread(fileName2);
    frame3 = imread(fileName3);

    %get marker centers
    colors = hsv(N);
    [BW1, BW2, center1, center2] = markers(frame2, frame3, colors, N, show, name(1,1));
    
    if sw == 1 
%         sortCnts1 = SetMarkers(frame2,N,1);
%         sortCnts2 = SetMarkers(frame3,N,2);
        load('results/sortCnts1');
        load('results/sortCnts2');
        center1 = sortCenter(sortCnts1, center1);
        center2 = sortCenter(sortCnts2, center2);
        center2_prev = center2;
        sw = 3;
    else
        if sw == 2 
            [bvalue,centerNew]=tracker(center1_prev, center1, v, t_prev{1}, t_now{1}, colors, N, show, name(1,1), BW1);
            if(bvalue==false)
                sw = 3;
            else
               center1 = centerNew;
            end
        end
        if sw == 3 
            [v,center1] = calculateV(center1_prev, center1, t_prev{1}, t_now{1}, BW1, N, colors, show, name(1,1));
            sw=2;
        end
    end
    %find equivalent of each marker
    matches = epi(BW1, BW2, center1, center2, center2_prev, colors, N, show, name(1,1));
    %sorting
    center2=SortMatches(matches,center2);
    %get marker's 3d pose in the world coordinate 
    point3d = reconstruct3d(frame2, frame3, center1, center2); 
%     excelWriter(point3d);
    draw(frame2, frame3, center1, center2, colors, name(1,1));
    
    t_prev = t_now;
    center1_prev = center1;
    center2_prev = center2;
end


