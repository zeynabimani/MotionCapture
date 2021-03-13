function ExcelWriter()
    % load array
    load('results/timeDiff');
    load('results/point3d');
    load('results/Frame');
   
 
    checkforfile=exist(strcat(pwd,'\','ExcelFile.xls'),'file');
    if checkforfile==0; % if not create new one
        header = {'PathFileType','4','(X/Y/Z)','ExcelFile.xls'};
        xlswrite('ExcelFile',header,'Sheetname','A1');
        header2 = {'DataRate','CameraRate','NumFrames','NumMarkers','Units','OrigDataRate','OrigDataStartFrame','OrigNumFrames'};
        xlswrite('ExcelFile',header2,'Sheetname','A2');
    else % if yes, count the number of previous inputs
        recycle on; % Send to recycle bin instead of permanently deleting.
        delete('ExcelFile'); 
    %     N=size(xlsread('ExcelFile','Sheetname'),1);
    end
    % add the new values (your input) to the end of Excel file
    values={'Frame#','Time'};
    varN=['C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',"AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR"];
    var2={'C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','A.1','A.2','A.3',"A.4","A.5","A.6","A.7","A.8","A.9","A.O","A.P","A.C","A.M","A.I","A.B","A.L","A.C","A.X"};
    xlswrite('ExcelFile',values,'Sheetname','A4');
    for i=1:3:33
        xlswrite('ExcelFile',var2(i),'Sheetname',strcat(varN(i),num2str(4)));
    end
    A={'X1','Y1','Z1','X2','Y2','Z2','X3','Y3','Z3','X4','Y4','Z4','X5','Y5','Z5','X6','Y6','Z6','X7','Y7','Z7','X8','Y8','Z8','X9','Y9','Z9','X10','Y10','Z10','X11','Y11','Z11',};
    xlswrite('ExcelFile',A,'Sheetname','C5');
    count=7;
    %this is rate array for row3
    rate={'6','6','49','11','mm','6','1','49'};
    xlswrite('ExcelFile',rate,'Sheetname','A3');
    for j=1:length(Frame)
        xlswrite('ExcelFile',j,'Sheetname',strcat('A',num2str(count)));
        xlswrite('ExcelFile',time(j),'Sheetname',strcat('B',num2str(count)));
       
         xlswrite('ExcelFile',pointNew(j,:),'Sheetname',strcat('C',num2str(count)));
        
        count=count+1;
    end
    % for i=1:size(Point3d)
    %     xlswrite('ExcelFile',{num2str(i)},'Sheetname',strcat('A',num2str(i+1)));
    %     xlswrite('ExcelFile',Point3d(i,1:3),'Sheetname',strcat('B',num2str(i+1)));
    % end
    %foe write in one cell
    %cellstr(Frame(j))
end



