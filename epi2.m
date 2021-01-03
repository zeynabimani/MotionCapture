function lineAllocate = epi2(img1, img2, center1, center2)
    %%load result of estimateFundamentalMatrix for 2 chess board image
    load('F:\MotionCapture\results\F_KAZE');

    epiLines2 = epipolarLine(fLMedS,center1);
    points2 = lineToBorderPoints(epiLines2,size(img2));
    lineAllocate = zeros(1,size(center2,1));
    for i=1:size(center2,1)
        lineAllocate(i) = calculateDistance(center2(i,:), points2);
    end
    uniqueNums = unique(lineAllocate); % unique elements of A in array B
    Ncount = histc(lineAllocate, uniqueNums); % the number of occurences of each unique element
    wrongs = uniqueNums(Ncount >= 2);

    for i=1:size(wrongs,2)
        wrongCnt1 = center1(lineAllocate == wrongs(i),:);
        wrongCnt2 = center2(lineAllocate == wrongs(i),:); 
        wrongCnt1 = sortrows(wrongCnt1);
        wrongCnt2 = sortrows(wrongCnt2);
        for j=1:size(wrongCnt1,1)
            [row1, column1] = find((center1 == wrongCnt1(j,:)) == 1);
            [row2, column2] = find((center2 == wrongCnt2(j,:)) == 1);
            lineAllocate(row1(1)) = row2(1);
        end
    end
    
    %epiLines in img1
    subplot(1,2,1),imshow(img1);
    hold on;
    colors = [];
    for i=1:size(center1,1)
        color = [rand,rand,rand];
        colors = [colors
                  color];
        plot(center1(i,1),center1(i,2),'o','Color',color,'MarkerSize',3);
    end
    %epiLines in img2
    subplot(1,2,2),imshow(img2);
    hold on;
    for i=1:size(center2,1)
        plot(center2(lineAllocate(i),1),center2(lineAllocate(i),2),'o','Color',colors(i, :),'MarkerSize',3);
        line(points2(lineAllocate(i),[1,3])',points2(lineAllocate(i),[2,4])','Color',colors(i, :));
    end
    
end
