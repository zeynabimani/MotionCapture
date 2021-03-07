function Center1 = sortCenter(sortCnts, Ct1)
    matches = findMatches(sortCnts,Ct1); %sort unsort
    Center1 = SortMatches(matches,Ct1);
end