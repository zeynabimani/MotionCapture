I1 = imread("75_1.jpg");
I2 = imread("75_2.jpg");

%%single channel image
I1gray = rgb2gray(I1);
I2gray = rgb2gray(I2);

%%thresholding
level = 50;
BW1 = I1gray > level;
BW2 = I2gray > level;
subplot(1,2,1), imshow(BW1)
subplot(1,2,2), imshow(BW2)

%%find contours
%%find contour areas - find max 2 area - find center of these max areas
areas1 = regionprops(BW1, 'Area');  %find eareas of all contours in img1
areas1 = cell2mat(struct2cell(areas1)); %convert struct to array in img1
areas1_m = maxk(areas1,2);  %find 2 biggest areas in img1
areas1_m_i = zeros(1,2);    %find index of 2 biggest areas in img1
areas1_m_i(1) = find(areas1 == areas1_m(1));
areas1_m_i(2) = find(areas1 == areas1_m(2));
areas2 = regionprops(BW2, 'Area');  %find eareas of all contours in img2
areas2 = cell2mat(struct2cell(areas2)); %convert struct to array in img2
areas2_m = maxk(areas2,2);  %find 2 biggest areas in img2
areas2_m_i = zeros(1,2);    %find index of 2 biggest areas in img2
areas2_m_i(1) = find(areas2 == areas2_m(1));
areas2_m_i(2) = find(areas2 == areas2_m(2));
center1 = regionprops(BW1, 'Centroid');  %find centers of all contours in img1
center1 = cell2mat(struct2cell(center1)); %convert struct to array in img2
center1_m = zeros(2,2); %find 2 centers areas in img2
center1_m(1,:) = center1(1,areas1_m_i(1)*2-1:areas1_m_i(1)*2);
center1_m(2,:) = center1(1,areas1_m_i(2)*2-1:areas1_m_i(2)*2);
center2 = regionprops(BW2, 'Centroid');  %find centers of all contours in img2
center2 = cell2mat(struct2cell(center2)); %convert struct to array in img2
center2_m = zeros(2,2); %find 2 centers areas in img2
center2_m(1,:) = center2(1,areas2_m_i(1)*2-1:areas2_m_i(1)*2);
center2_m(2,:) = center2(1,areas2_m_i(2)*2-1:areas2_m_i(2)*2);

[B1,L1] = bwboundaries(BW1,'noholes');
[B2,L2] = bwboundaries(BW2,'noholes');
%%draw contours
figure
subplot(1,2,1);
imshow(label2rgb(L1, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B1)
   boundary = B1{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
plot(center1_m(1,1),center1_m(1,2),'o','Color','w','MarkerSize',6,'MarkerFaceColor','w')
plot(center1_m(2,1),center1_m(2,2),'o','Color','w','MarkerSize',6,'MarkerFaceColor','w')

subplot(1,2,2);
imshow(label2rgb(L2, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B2)
   boundary = B2{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
plot(center2_m(1,1),center2_m(1,2),'o','Color','w','MarkerSize',6,'MarkerFaceColor','w')
plot(center2_m(2,1),center2_m(2,2),'o','Color','w','MarkerSize',6,'MarkerFaceColor','w')


epi2(I1gray, I2gray, center1_m, center2_m);
