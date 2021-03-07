function lineAllocate = epi(img1, img2, center1, center2, center2_prev, colors, N, show, num)
    %%load result of estimateFundamentalMatrix for 2 chess board image
    load('results/F_KAZE');

    epiLines2 = epipolarLine(fLMedS,center1);
    points2 = lineToBorderPoints(epiLines2,size(img2));
    dists = zeros(N,N);
    for i=1:N
        dists(i,:) = calculateDistance(center2(i,:), points2);
    end
    marks = dists;
    for i=1:N
        marks(i,:) = dists(i,:) < 7;
    end
    
    for i=1:N
       if sum(marks(i,:) == 1) > 1
          candids = find(marks(i,:) == 1);
          minDist = 9999;
          minIndex = 0;
          for j=1:size(candids,2)
              dist = pointDist(center2_prev(candids(1,j),:),center2(i,:));
              if dist < minDist
                  minDist = dist;
                  minIndex = candids(1,j);
              end
          end
          marks(i,:) = zeros(1,N);
          marks(i,minIndex) = 1;      
       end
    end 
    
    lineAllocate = zeros(1,N);
    for i=1:N
        if sum(marks(:,i) == 1) > 1 || sum(marks(:,i) == 1) == 0
           matches = findMatches(center2_prev,center2); %sort unsort   
           lineAllocate(i) = matches(i,1);
        else
            lineAllocate(i) = find(marks(:,i) == 1);
        end
    end
    
    if show == true
        %epiLines in img2
        subplot(1,2,1),imshow(img1);
        hold on;
        for i=1:N
            plot(center1(i,1),center1(i,2),'o','Color',colors(i,:),'MarkerSize',5,'LineWidth',3);
        end
        %epiLines in img1
        subplot(1,2,2),imshow(img2);
        hold on;
        for i=1:N
            line(points2(i,[1,3])',points2(i,[2,4])','Color',colors(i,:));
            plot(center2(lineAllocate(i),1),center2(lineAllocate(i),2),'o','Color',colors(i, :),'MarkerSize',5,'LineWidth',3);
        end
        saveas(gcf,string("res/" + string(num) + "_4_epi.jpg"));
    end
end