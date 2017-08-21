%%%%%%%REMOVE DUPLICATE%%%%%%
function[Students]=remove_duplicate(Students,upper_limit,lower_limit)
format long;
global ll ul
%判断数组是否相等1-2,3,4；2-3,4,5
%如果相同，则重新初始化一个数据
for i = 1:length(Students)
    Mark_1 = sort(Students(i).mark);
     for k = i + 1:length(Students);
           Mark_2 = sort(Students(k).mark);
           if isequal(Mark_1,Mark_2)
                    m_new = floor(1+(length(Students(k).mark)-1)*(rand));
                if length(upper_limit)==1
                    Students(k).mark(m_new)=(lower_limit+(upper_limit-lower_limit)*rand);
                else
                    Students(k).mark(m_new)=(ll(m_new)+(upper_limit(m_new)-ll(m_new))*rand);
                end
           end
     end
end
return;
