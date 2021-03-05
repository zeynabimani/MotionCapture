function Center1 = sortCenter(sortCnts, Ct1)
    matches = findMatches(sortCnts,Ct1);
    Center1 = SortMatches(matches,Ct1);
end