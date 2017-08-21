%%%%%%INITIALIZATION,initialization%%%%%%%
function[Students,select,upper_limit,lower_limit,ini_fun,min_result,avg_result,result_fun,opti_fun,result_fun_new,opti_fun_new]=Initialize(note1,obj_fun,RandSeed)
format long;
select.classsize = 100;
select.var_num = 5;
select.itration = 300;
if ~exist('RandSeed','var')
    rand_gen=round(sum(100*clock));
end
% rand('state',rand_gen);
rand('state',82163);
[ini_fun,result_fun,result_fun_new,opti_fun,opti_fun_new]=obj_fun();
[upper_limit,lower_limit,Students,select]=ini_fun(select);
    Students = remove_duplicate(Students,upper_limit,lower_limit);%去除重复
    Students = result_fun(select,Students);%求取适应度
    Students = sortstudents(Students);%按照适应度，排序，
    average_result = result_avg(Students);%整个种群的平均适应度值
    min_result = [Students(1).result];%整个种群的最优适应度值
    avg_result = [average_result];%整个种群的平均适应度值
    return;