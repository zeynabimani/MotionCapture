load('center1');
load('center2');

NumberOfMarks = 14;
new_center1 = zeros(NumberOfMarks,2);
new_center2 = zeros(NumberOfMarks,2);

chosen = [1, 8, 2, 3, 5, 6, 9, 10, 11, 22, 12, 13, 14, 19];
chosen = chosen + 1;
for i=1:size(chosen,2)
    new_center1(i,:) = center1(chosen(i),:);
    new_center2(i,:) = center2(chosen(i),:);
end

save('new_center1.mat','new_center1');
save('new_center2.mat','new_center2');