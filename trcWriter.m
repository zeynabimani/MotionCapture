disp('Writing trc file...') 

%Output marker data to an OpenSim TRC file
newfilename = strrep('TrcFile','c3d','trc');
pname = 'results/';
data.TRC_Filename = [pname newfilename];

%open the file
fid_1 = fopen([pname newfilename],'w');

% first write the header data
fprintf(fid_1,'PathFileType\t4\t(X/Y/Z)\t %s\n',newfilename);
data.Rate = 6;
frameNum = 49;
nmarkers = 11;
data.units = 'mm';
data.Start_Frame = 1;
data.End_Frame = 49;
fprintf(fid_1,'DataRate\tCameraRate\tNumFrames\tNumMarkers\tUnits\tOrigDataRate\tOrigDataStartFrame\tOrigNumFrames\n');
fprintf(fid_1,'%d\t%d\t%d\t%d\t%s\t%d\t%d\t%d\n', data.Rate, data.Rate, frameNum, nmarkers, data.units, data.Rate,data.Start_Frame,data.End_Frame); 
fprintf(fid_1,'Frame#\tTime\t');
%%should change when the namber of markers are changed
names = {'Center','R.A','L.A','R.B','L.B','R.C','L.C','R.D','L.D','R.E','L.E'};
for i=1:nmarkers
    n = names(1,i);
    fprintf(fid_1,'%s\t\t\t', n{1});
end
fprintf(fid_1,'\n\t\t');
xyz = {'X';'Y';'Z'};
for i=1:nmarkers
    for j=1:3
        n = xyz(j,1);
        n = n{1} + string(i);
        fprintf(fid_1,'%s\t', n);
    end
end
fprintf(fid_1,'\n\n');

% then write the output marker data
load('results/timeDiff');
load('results/point3d');
for i=1:frameNum
  fprintf(fid_1,'%d\t%f\t', i, time(i,1));   
  for j=1:size(pointNew,2)
      fprintf(fid_1,'%f\t', pointNew(i,j));
  end
  fprintf(fid_1,'\n'); 
end

% close the file
fclose(fid_1);

disp('Done.')
