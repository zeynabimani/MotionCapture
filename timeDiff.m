function out = timeDiff(time1, time2)
%     t1 = datestr(time1,'HH:MM:SS.FFF');
%     t2 = datestr(time2,'HH:MM:SS.FFF');
    t = {time1;time2};
    td = duration(t,'inputformat','hh:mm:ss.SSS');
    out = milliseconds(diff(td));
end