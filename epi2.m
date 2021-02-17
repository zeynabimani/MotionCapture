function lineAllocate = epi2(img1, img2, center1, center2, colors, N, num)
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
        marks(i,:) = dists(i,:) < 5;
    end
    bad = [];
    bad_index = [];
    for i=1:N
        ch = find(marks(:,i) == 1);
        if size(ch,1) > 1
            bad = [bad, ch];
            bad_index = [bad_index, i];
        end
    end
    lastBads = [];
    lastBads_index = [];
    for i=1:size(bad,2)-1
        for j=i+1:size(bad,2)
            if bad(:,i) == bad(:,j)
                lastBads_index = [lastBads_index, bad(:,i)];
                lastBads = [lastBads, [bad_index(i); bad_index(j)]];
            end
        end
    end
    for k=1:size(lastBads,2)
        wrongCnt1 = center1(lastBads(:,k),:);
        wrongCnt2 = center2(lastBads_index(:,k),:); 
        wrongCnt1 = sortrows(wrongCnt1);
        wrongCnt2 = sortrows(wrongCnt2);
        for j=1:size(wrongCnt1,1)
            [row1, column1] = find((center1 == wrongCnt1(j,:)) == 1);
            [row2, column2] = find((center2 == wrongCnt2(j,:)) == 1);
            marks(row2(1),:) = zeros(N,1);
            marks(row2(1), row1(1)) = 1;
        end
    end
    bad = [];
    bad_index = [];
    for i=1:N
        ch = find(marks(:,i) == 1);
        if size(ch,1) > 1
            bad = [bad, ch];
            bad_index = [bad_index, i];
        end
    end
    for i=1:N
        for j=1:size(bad_index,2)
            if marks(i,bad_index(j)) == 1
                if sum(marks(i,:) == 1) == 1
                    marks(:,bad_index(j)) = zeros(N,1);
                    marks(i, bad_index(j)) = 1;
                end
            end
        end
    end
    lineAllocate = zeros(1,N);
    for i=1:N
       lineAllocate(i) = find(marks(:,i) == 1);
    end
    
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
    saveas(gcf,string("res/" + string(num) + "_4.jpg"));
end
