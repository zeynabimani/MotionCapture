function Center1=SortCenter1(Ct1)
load('results/Centers');
Center1=zeros(length(Centers),2);
min=99999;
global index;
for i=1:length(Centers)
for j=1:length(Ct1)
    minvl=sqrt((abs(Ct1(j,1)-Centers(i,1)).^2)+(abs(Ct1(j,2)-Centers(i,2)).^2));
    if minvl<min
        min=minvl;
        index=j;
    end
    
end
Center1(i)=Ct1(index);

end

end