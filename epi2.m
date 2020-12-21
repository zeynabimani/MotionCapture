function epi2(img1, img2, center1, center2)
    load('F_KAZE');
    %epiLines in img1
    subplot(1,2,1),imshow(img1);
    %epiLines in img2
    subplot(1,2,2),imshow(img2);
    hold on;
    plot(center2(:,1),center2(:,2),'go');
    epiLines2 = epipolarLine(fLMedS,center1);
    points2 = lineToBorderPoints(epiLines2,size(img2));
    line(points2(:,[1,3])',points2(:,[2,4])');
end
