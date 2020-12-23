function epi2(img1, img2, center1, center2)
    %%load result of estimateFundamentalMatrix for 2 chess board image
    load('results/F_KAZE');
    %epiLines in img1
    subplot(1,2,1),imshow(img1);
    %epiLines in img2
    subplot(1,2,2),imshow(img2);
    hold on;
    
    epiLines2 = epipolarLine(fLMedS,center1);
    points2 = lineToBorderPoints(epiLines2,size(img2));
    lineAllocate = zeros(1,size(center2,1));
    for i=1:size(center2,1)
        lineAllocate(i) = calculateDistance(center2(i,:), points2);
        color = [rand,rand,rand];
        plot(center2(i,1),center2(i,2),'o','Color',color,'MarkerSize',3);
        line(points2(lineAllocate(i),[1,3])',points2(lineAllocate(i),[2,4])','Color',color);
    end
    
end
