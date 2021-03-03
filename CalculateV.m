function [v,center2Sort]=CalculateV(centert1,centert2,t1,t2)
%sort points
    matches=findMatches(centert1,centert2);
    center2Sort=SortMatches(matches,centert2);
    %find v
    v=zeros(1,2);
      v(1,1)=mean(centert1(:,1)-center2Sort(:,1))/(t2-t1);
      v(1,2)=mean(centert1(:,2)-center2Sort(:,2))/(t2-t1);
end