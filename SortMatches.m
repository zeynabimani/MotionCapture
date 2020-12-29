function Center2=SortMatches(maches,center2)
 Center2=zeros(length(maches));

for i=1:(length(maches))
if maches(i)~=i
    Center2(i,:)=center2(maches(i),:);   
end
  disp(Center2);
end