function [center1_max, center2_max] = markers(I1, I2, K, show)

    % I1 = imread("75_1.jpg");
    % I2 = imread("75_2.jpg");

    %%single channel image
    I1gray = rgb2gray(I1);
    I2gray = rgb2gray(I2);

    %%thresholding
    level = 50;
    BW1 = I1gray > level;
    BW2 = I2gray > level;
    subplot(1,2,1), imshow(BW1)
    subplot(1,2,2), imshow(BW2)

%%%     k = 1; %number of markers in the image view

    %%find contours
    %%find eareas of all contours
    areas1 = regionprops(BW1, 'Area');  
    areas2 = regionprops(BW2, 'Area');
    %convert struct to array
    areas1 = cell2mat(struct2cell(areas1)); 
    areas2 = cell2mat(struct2cell(areas2));
    %find k biggest areas
    areas1_max = maxk(areas1,K);  
    areas2_max = maxk(areas2,K);
    %find index of k biggest areas
    areas1_max_index = zeros(1,K);
    areas2_max_index = zeros(1,K);
    for i=1:K
        areas1_max_index(i) = find(areas1 == areas1_max(i));
        areas2_max_index(i) = find(areas2 == areas2_max(i));
    end

    %find centers of all contours
    center1 = regionprops(BW1, 'Centroid');  
    center2 = regionprops(BW2, 'Centroid');  
    %convert struct to array
    center1 = cell2mat(struct2cell(center1)); 
    center2 = cell2mat(struct2cell(center2));
    %find k centers 
    center1_max = zeros(K,2); 
    center2_max = zeros(K,2);
    for i=1:K
        center1_max(i,:) = center1(1,areas1_max_index(i)*2-1:areas1_max_index(i)*2);
        center2_max(i,:) = center2(1,areas2_max_index(i)*2-1:areas2_max_index(i)*2);
    end

    %find corners of all contours
    corners1 = regionprops(BW1, 'Extrema');  
    corners2 = regionprops(BW2, 'Extrema');  
    %convert struct to array
    corners1 = cell2mat(struct2cell(corners1)); 
    corners2 = cell2mat(struct2cell(corners2));
    %find k corners
    corners1_max = zeros(K,8,2); 
    corners2_max = zeros(K,8,2);
    for i=1:K
        corners1_max(i,:,:) = corners1(:,areas1_max_index(i)*2-1:areas1_max_index(i)*2);
        corners2_max(i,:,:) = corners2(:,areas2_max_index(i)*2-1:areas2_max_index(i)*2);
    end

    points1 = zeros(K,9,2); 
    points2 = zeros(K,9,2); 
    points1(:,1,:) = center1_max;
    points2(:,1,:) = center2_max;
    points1(:,2:9,:) = corners1_max;
    points2(:,2:9,:) = corners2_max;

    if show == true
                subplot(1,2,1), imshow(I1);
        hold on
        colors = ["#f44336", "#9C27B0", "#2196F3", "#4CAF50", "#FFEB3B", "#FF5722", "#3F51B5", "#E91E63", "#18FFFF"];
        for i=1:size(points1,2)
           for j=1:K
               plot(points1(j,i,1),points1(j,i,2),'o','Color',char(colors(i)),'MarkerSize',3)
           end
        end
        subplot(1,2,2), imshow(I2);
        hold on
        for i=1:size(points2,2)
           for j=1:K
               plot(points2(j,i,1),points2(j,i,2),'o','Color',char(colors(i)),'MarkerSize',3)
           end
        end
    end
end