function excelWriter(Point3d)
    % N tedad frame
    N=1;
    checkforfile=exist(strcat(pwd,'\','ExcelFile.xls'),'file');
    if checkforfile==0; % if not create new one
        header = {'PathFileType','4','(X/Y/Z)','subject01_walk1.trc'};
        xlswrite('ExcelFile',header,'Sheetname','A1');
        header2 = {'DataRate','CameraRate','NumMarkers','Units','OrigDataRate','OrigDataStartFrame','OrigNumFrames'};
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
    for i=1:3:42
        xlswrite('ExcelFile',var2(i),'Sheetname',strcat(varN(i),num2str(4)));
    end
    A={'x1','y1','z1','x2','y2','z2','x3','y3','z3','x4','y4','z4','x5','y5','z5','x6','y6','z6','x7','y7','z7','x8','y8','z8','x9','y9','z9','x10','y10','z10','x11','y11','z11','x12','y12','z12','x13','y13','z13','x14','y14','z14'};
    xlswrite('ExcelFile',A,'Sheetname','C5');
    count=7;
    Point3dNew=Point3d(:)';
    for j=1:N
        xlswrite('ExcelFile',j,'Sheetname',strcat('A',num2str(count)));
        for k=1:size(Point3dNew)
             xlswrite('ExcelFile',Point3dNew(k,1:end),'Sheetname',strcat('C',num2str(count)));
        end
        count=count+1;
    end
    % for i=1:size(Point3d)
    %     xlswrite('ExcelFile',{num2str(i)},'Sheetname',strcat('A',num2str(i+1)));
    %     xlswrite('ExcelFile',Point3d(i,1:3),'Sheetname',strcat('B',num2str(i+1)));
    % end
end



