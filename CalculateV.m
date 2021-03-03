function v=CalculateV(centert1,centert2,t1,t2)
centert2=Sorting(centert1,centert2);
v=zeros(1,2);
  v(1,1)=mean(centert1(:,1)-centert2(:,1))/(t2-t1);
  v(1,2)=mean(centert1(:,2)-centert2(:,2))/(t2-t1);
end