function draw(I1, I2, center1, center2, colors, num)
    subplot(1,2,1), imshow(I1);
    hold on
    for i=1:size(center1,1)
       plot(center1(i,1),center1(i,2),'o','Color',colors(i,:),'MarkerSize',5,'LineWidth',3)
    end
    subplot(1,2,2), imshow(I2);
    hold on
    for i=1:size(center2,1)
        plot(center2(i,1),center2(i,2),'o','Color',colors(i,:),'MarkerSize',5,'LineWidth',3)
    end
    saveas(gcf,string("res/" + string(num) + "_3.jpg"));
end