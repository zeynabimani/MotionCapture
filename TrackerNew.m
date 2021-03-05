function [bVariable,point]=TrackerNew(Center1T1,Center1T2,v,t2,t1,Colors,N,num,BW1)
   %sort Center1T2
   point=zeros(14,2);
    center_witherror=zeros(14,2);
    center_witherror(:,1)=Center1T1(:,1)+(v(:,1).*(t2-t1));
    center_witherror(:,2)=Center1T1(:,2)+(v(:,2).*(t2-t1));
    matches=findMatches(center_witherror,Center1T2);
     Center1T2  = SortMatches(matches,Center1T2);
%find err between center_witherror and Center1T2
    err=sqrt((mean(center_witherror(:,1)-Center1T2(:,1))^2)+(mean(center_witherror(:,2)-Center1T2(:,2))^2))
    thereshold=4;
    if(err>thereshold)
        bVariable=false;
    else
        point=Center1T2;
        bVariable=true;
       imshow(BW1);
    hold on;
    for i=1:N
        plot(point(i,1),point(i,2),'o','Color',Colors(i,:),'MarkerSize',5,'LineWidth',3);
    end
    saveas(gcf,string("res/" + string(num) + "_8.jpg"));
    end
    %plot tracks
  

end
