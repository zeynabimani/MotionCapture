function SortCenter=Sorting(center1,center2)
SortCenter=zeros(length(center2),2);
min=99999;
global index;
for i=1:length(center1)
for j=1:length(center2)
    minvl=sqrt((abs(center2(j,1)-center1(i,1)).^2)+(abs(center2(j,2)-center1(i,2)).^2));
    if minvl<min
        min=minvl;
        index=j;
    end
    
end
SortCenter(i)=center2(index);

end

end