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
    Students = remove_duplicate(Students,upper_limit,lower_limit);%ȥ���ظ�
    Students = result_fun(select,Students);%��ȡ��Ӧ��
    Students = sortstudents(Students);%������Ӧ�ȣ�����
    average_result = result_avg(Students);%������Ⱥ��ƽ����Ӧ��ֵ
    min_result = [Students(1).result];%������Ⱥ��������Ӧ��ֵ
    avg_result = [average_result];%������Ⱥ��ƽ����Ӧ��ֵ
    return;