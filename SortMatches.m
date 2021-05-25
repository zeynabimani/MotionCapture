function Center2=sortMatches(maches,center2)
    Center2=zeros(length(maches),2);
    for i=1:(length(maches))
        if maches(i)~=i
            Center2(i,:)=center2(maches(i),:);
        else
            Center2(i,:)=center2(i,:);
        end
    end
end