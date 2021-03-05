function [v,center2Sort]=CalculateV(centert1,centert2,t1,t2,BW1,N,Colors,num)
%sort points
    matches=findMatches(centert1,centert2);
    center2Sort=SortMatches(matches,centert2);
   subplot(1,1,1), imshow(BW1);
    hold on;
    for i=1:N
        plot(center2Sort(i,1),center2Sort(i,2),'o','Color',Colors(i,:),'MarkerSize',5,'LineWidth',3);
         
    end
    saveas(gcf,string("res/" + string(num) + "_7.jpg"));
    %find v
    v=zeros(1,2);
      v(1,1)=mean(centert1(:,1)-center2Sort(:,1))/(t2-t1);
      v(1,2)=mean(centert1(:,2)-center2Sort(:,2))/(t2-t1);
end