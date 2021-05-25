
I1 = imread("results/10_1.jpg");
I2 = imread("results/10_2.jpg");

%%single channel image
I1gray = rgb2gray(I1);
I2gray = rgb2gray(I2);

epipolar1(I1gray, I2gray)

function epipolar1(img1, img2)
    %%detect match point between images
    points1 = detectKAZEFeatures(img1);
    points2 = detectKAZEFeatures(img2);
    [features1, valid_points1] = extractFeatures(img1, points1);
    [features2, valid_points2] = extractFeatures(img2, points2);
    indexPairs = matchFeatures(features1, features2);
    matchedPoints1 = valid_points1(indexPairs(:, 1), :);
    matchedPoints2 = valid_points2(indexPairs(:, 2), :);
    
    %%find Fundamental Matrix
    [fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1.Location, matchedPoints2.Location);
    save('results/F_KAZE', 'fLMedS');
    %epiLines in img1
    subplot(1,2,1),imshow(img1);
    hold on;
    plot(matchedPoints1.Location(inliers,1),matchedPoints1.Location(inliers,2),'go');
    epiLines1 = epipolarLine(fLMedS',matchedPoints2.Location(inliers,:));
    points1 = lineToBorderPoints(epiLines1,size(img1));
    line(points1(:,[1,3])',points1(:,[2,4])');
    %epiLines in img2
    subplot(1,2,2),imshow(img2);
    hold on;
    plot(matchedPoints2.Location(inliers,1),matchedPoints2.Location(inliers,2),'go');
    epiLines2 = epipolarLine(fLMedS,matchedPoints1.Location(inliers,:));
    points2 = lineToBorderPoints(epiLines2,size(img2));
    line(points2(:,[1,3])',points2(:,[2,4])');
end
