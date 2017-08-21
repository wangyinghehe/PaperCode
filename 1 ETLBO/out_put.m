%%%%%%%OUTPUT%%%%%%%
function out_put(note1,select,Students,within_bound,min_result)
format long;
if  note1
     duplicate_no = 0;
     for i =1:select.classsize
           Mark_1 = sort(Students(i).mark);
         for k = i + 1:select.classsize;
             Mark_2 = sort(Students(k).mark);
             if isequal(Mark_1,Mark_2)
                 duplicate_no =duplicate_no +1;
             end
         end
     end
     Mark = sort(Students(1).mark);
end
return;
