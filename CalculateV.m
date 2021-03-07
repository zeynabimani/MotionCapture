function [v,center2Sort]=calculateV(centert1,centert2,t1,t2,BW1,N,Colors,show,num)
    matches=findMatches(centert1,centert2); %sort unsort
    center2Sort=SortMatches(matches,centert2);
    %find v
    tDiff = timeDiff(t1,t2);
    v=zeros(1,2);
    v(1,1)=mean(centert1(:,1)-center2Sort(:,1))/tDiff;
    v(1,2)=mean(centert1(:,2)-center2Sort(:,2))/tDiff;
    if show == true
        figure
        imshow(BW1);
        hold on;
        for i=1:N
            plot(center2Sort(i,1),center2Sort(i,2),'o','Color',Colors(i,:),'MarkerSize',5,'LineWidth',3);
        end
        saveas(gcf,string("res/" + string(num) + "_2_calV.jpg"));
    end
end