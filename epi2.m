function lineAllocate = epi2(img1, img2, center1, center2, num)
    %%load result of estimateFundamentalMatrix for 2 chess board image
    load('results/F_KAZE');

    epiLines2 = epipolarLine(fLMedS,center1);
    points2 = lineToBorderPoints(epiLines2,size(img2));
    lineAllocate = zeros(1,size(center2,1));
    flags = zeros(1,size(center2,1));
    for i=1:size(center2,1)
        chosen = calculateDistance(center2(i,:), points2, flags);
        lineAllocate(i) = chosen;
        flags(chosen) = 1;
    end
    
    %epiLines in img1
    subplot(1,2,1),imshow(img1);
    hold on;
    colors = [];
    for i=1:size(center1,1)
        color = [rand,rand,rand];
        colors = [colors
                  color];
        plot(center1(i,1),center1(i,2),'o','Color',color,'MarkerSize',15);
    end
    %epiLines in img2
    subplot(1,2,2),imshow(img2);
    hold on;
    for i=1:size(center2,1)
        plot(center2(lineAllocate(i),1),center2(lineAllocate(i),2),'o','Color',colors(i, :),'MarkerSize',15);
        line(points2(i,[1,3])',points2(i,[2,4])','Color',colors(i, :));
    end
    saveas(gcf,string("res/" + string(num) + ".jpg"));
end
