%%%AVG_RESULT%%%%%%%
function[result_av,within_bound] = result_avg(Students)
format long;
Result=[];
within_bound = 0;
for i =1:length(Students)
    if Students(i).result < inf
        Result = [Result Students(i).result];
        within_bound=within_bound+1;
    end
end
result_av = mean(Result);%整个种群的适应度平均值
return;
