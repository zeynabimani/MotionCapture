function [BW1, BW2, center1_max, center2_max] = markers(I1, I2, colors, K, show, num)

    % I1 = imread("75_1.jpg");
    % I2 = imread("75_2.jpg");

    %%single channel image
    I1gray = rgb2gray(I1);
    I2gray = rgb2gray(I2);

    %%thresholding
    level = 35;
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
    index1 = 1;
    lastBad1 = 0;
    index2 = 1;
    lastBad2 = 0;
    for i=1:K
        tmp = find(areas1 == areas1_max(i));
        if size(tmp,2) > 1
            if lastBad1 ~= areas1_max(i)
                index1 = 1;
            end
            areas1_max_index(i) = tmp(index1);
            lastBad1 = areas1_max(i);
            index1 = index1 + 1;
        else
            areas1_max_index(i) = tmp;
        end
        tmp = find(areas2 == areas2_max(i));
        if size(tmp,2) > 1
            if lastBad2 ~= areas2_max(i)
                index2 = 1;
            end
            areas2_max_index(i) = tmp(index2);
            lastBad2 = areas2_max(i);
            index2 = index2 + 1;
        else
            areas2_max_index(i) = tmp;
        end
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
    if show == true
        subplot(1,2,1), imshow(I1);
        hold on
        for i=1:size(center1_max,1)
           plot(center1_max(i,1),center1_max(i,2),'o','Color',colors(i,:),'MarkerSize',5,'LineWidth',3)
        end
        subplot(1,2,2), imshow(I2);
        hold on
        for i=1:size(center2_max,1)
            plot(center2_max(i,1),center2_max(i,2),'o','Color',colors(i,:),'MarkerSize',5,'LineWidth',3)
        end
        saveas(gcf,string("res/" + string(num) + "_1.jpg"));
    end
end