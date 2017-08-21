%%%%%%%%%%%TLBO%%%%%%%%%%
%%(ctrl+z )
function TLBO(obj_fun,note1,note2)
global FES FES_etlbo min_etlbo avg_etlbo run_time mark_etlbo time_etlbo ;
format long;
global ll ul
if ~exist('note1','var')
    note1 = true;
end
if ~exist('note2','var')
    note2 = true;
end
[Students,select,upper_limit,lower_limit,ini_fun,min_result,avg_result,result_fun,opti_fun,result_fun_new,opti_fun_new] = Initialize(note1,obj_fun);
%淘汰人数调整
eliminate = 0;
diedai=select.itration;
TOC=zeros(1,diedai);
FES1=zeros(1,diedai);
COMP = 1;
while(FES<40000)
    tic
    for   i = 1:length(Students) %取临时变量，便于进行操作
        cs(i,:) = Students(i).mark;
        cs_result(i) = Students(i).result;
    end
    cs;
    cs_result;
    %整个种群迭代，循环（顺序抽取学生，进行教师阶段，学生阶段的学习）
    for i = 1:length(Students)
        mean_result = mean(cs);%每一科目的均值[89 38 36 37 35]
        TF = round(1+rand*(1));
        % [B,ind]=sort(A)，计算后，B是A排序后的向量，A保持不变，
        % ind是B中每一项对应于A 中项的索引。排序是安升序进行的。
        %按照适应度排序，r1-适应度 r2-原索引序号
        [r1 r2] = sort(cs_result);
        %教学阶段，向教师学习
        best = cs(r2(1),:);
        for k = 1:select.var_num
            cs_new(i,k) = cs(i,k)+((best(1,k)-TF*mean_result(k))*rand);
        end
        cs_new(i,:) = opti_fun_new(select,cs_new(i,:));%确保最优值位于定义域内，不在则取其相邻边界值
        cs_new_result(i) = result_fun_new(select,cs_new(i,:));
        if cs_new_result(i) < Students(i).result %比较适应度值，如果更优则替代
            Students(i).mark = cs_new(i,:);
            cs(i,:) = cs_new(i,:);
            Students(i).result = cs_new_result(i);
        end
        hh = ceil(length(Students)*rand);%随机选取一个学生
        while hh == i
            hh = ceil(length(Students)*rand);
        end
        %比较适应度，如果较优，，；如果较差，，（老师和任意一个学生比较）     
        if Students(i).result < Students(hh).result
            for k = 1:select.var_num
                cs_new(i,k) = Students(i).mark(k)+((Students(i).mark(k)-Students(hh).mark(k))*rand);
            end
        else
            for k = 1:select.var_num
                cs_new(i,k) = Students(i).mark(k)+((Students(hh).mark(k)-Students(i).mark(k))*rand);
            end
        end      
        cs_new(i,:) = opti_fun_new(select,cs_new(i,:)); %确保没有出界，如果出界，取其边界值
        cs_new_result(i) = result_fun_new(select,cs_new(i,:));%更新位置后的适应度
        if cs_new_result(i)<Students(i).result  %如果优于，则替代
            Students(i).mark = cs_new(i,:);
            cs(i,:) = cs_new(i,:);
            Students(i).result = cs_new_result(i);
        end
    end %整个种群迭代   
    n = length(Students); 
    for i = 1:eliminate %物竞天择---eliminate淘汰机制
        for popindex =(n-(i-1)):select.classsize
            for k=1:select.var_num
                mark(k)=(ll(k))+((ul(k)-ll(k))*rand);
            end
            Students(popindex).mark = mark;
        end
    end
    Students = opti_fun(select,Students);%确保所有粒子都位于界限内
    Students = result_fun(select,Students);%新一代，种群的适应值
    Students = sortstudents(Students);%重新排序
    if rand<1 %去除重复（否定了最优的粒子的继承性，没有遗传下来）
        Students = remove_duplicate(Students,upper_limit,lower_limit);
    end
    Students = sortstudents(Students);%重新排序
    [average_result,within_bound] = result_avg(Students);%整个种群的平均适应度（图形）
    min_result = [min_result Students(1).result];%最优适应度（图形）
    avg_result = [avg_result average_result];%（不断记录）
    Mark = (Students(1).mark);%最优适应度对应的位置
    if note1
        %                       disp([num2str(min_result(end))]);%输出到控制台界面
        %                       disp([num2str(Mark)]);
    end
    toc
    if COMP~=1
        TOC(1,COMP)=TOC(1,(COMP-1))+toc;
    else
        TOC(1,COMP)=toc;
    end
    FES1(1,COMP)=FES;
    COMP = COMP+1;
end
fprintf('第%d次运行', run_time);
fprintf('\n %e',min_result(end));
fprintf('\n %e',avg_result(end)) ;
fprintf('\n %6.10f',Mark);
fprintf('\n ********************** \n');
fprintf('\n %6.10f',FES);
out_put(note1,select,Students,within_bound,min_result);
%保存n次运行的过程不断迭代的，最优适应值和平均适应值 ----->然后画图
min_etlbo(run_time,1:length(min_result))=min_result;
avg_etlbo(run_time,1:length(avg_result))=avg_result;
time_etlbo(run_time,1:length(TOC))=TOC;
mark_etlbo(run_time,1:length(Mark(1,:)))=Mark(1,:);
FES_etlbo(run_time,1:length(FES1))=FES1;
if run_time==1
    save('ETLBO.mat','min_etlbo');
    save('ETLBO.mat','avg_etlbo','-append');
    save('ETLBO.mat','time_etlbo','-append');
    save('ETLBO.mat','mark_etlbo','-append');
    save('ETLBO.mat','FES_etlbo','-append');
else
    save('ETLBO.mat','min_etlbo','-append');
    save('ETLBO.mat','avg_etlbo','-append');
    save('ETLBO.mat','time_etlbo','-append');
    save('ETLBO.mat','mark_etlbo','-append');
    save('ETLBO.mat','FES_etlbo','-append');
end
