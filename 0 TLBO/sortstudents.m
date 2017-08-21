%%%%%%SORTSTUDENTS%%%%%%
function[Students,indices] = sortstudents(Students)
classsize =length(Students);
Result = zeros(1,classsize);
indices=zeros(1,classsize);
for i = 1:classsize
    Result(i) = Students(i).result;
end
[Result,indices] = sort(Result,2,'ascend');
Marks = zeros(classsize,length(Students(1).mark));
for i =1:classsize
    Marks(i,:) = Students(indices(i)).mark;
end
for i = 1:classsize
    Students(i).mark = Marks(i,:);
    Students(i).result = Result(i);
end
