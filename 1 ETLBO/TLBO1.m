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
%��̭��������
eliminate = 0;
diedai=select.itration;
TOC=zeros(1,diedai);
FES1=zeros(1,diedai);
COMP = 1;
while(FES<40000)
    tic
    for   i = 1:length(Students) %ȡ��ʱ���������ڽ��в���
        cs(i,:) = Students(i).mark;
        cs_result(i) = Students(i).result;
    end
    cs;
    cs_result;
    %������Ⱥ������ѭ����˳���ȡѧ�������н�ʦ�׶Σ�ѧ���׶ε�ѧϰ��
    for i = 1:length(Students)
        mean_result = mean(cs);%ÿһ��Ŀ�ľ�ֵ[89 38 36 37 35]
        TF = round(1+rand*(1));
        % [B,ind]=sort(A)�������B��A������������A���ֲ��䣬
        % ind��B��ÿһ���Ӧ��A ����������������ǰ�������еġ�
        %������Ӧ������r1-��Ӧ�� r2-ԭ�������
        [r1 r2] = sort(cs_result);
        %��ѧ�׶Σ����ʦѧϰ
        best = cs(r2(1),:);
        for k = 1:select.var_num
            cs_new(i,k) = cs(i,k)+((best(1,k)-TF*mean_result(k))*rand);
        end
        cs_new(i,:) = opti_fun_new(select,cs_new(i,:));%ȷ������ֵλ�ڶ������ڣ�������ȡ�����ڱ߽�ֵ
        cs_new_result(i) = result_fun_new(select,cs_new(i,:));
        if cs_new_result(i) < Students(i).result %�Ƚ���Ӧ��ֵ��������������
            Students(i).mark = cs_new(i,:);
            cs(i,:) = cs_new(i,:);
            Students(i).result = cs_new_result(i);
        end
        hh = ceil(length(Students)*rand);%���ѡȡһ��ѧ��
        while hh == i
            hh = ceil(length(Students)*rand);
        end
        %�Ƚ���Ӧ�ȣ�������ţ���������ϲ������ʦ������һ��ѧ���Ƚϣ�     
        if Students(i).result < Students(hh).result
            for k = 1:select.var_num
                cs_new(i,k) = Students(i).mark(k)+((Students(i).mark(k)-Students(hh).mark(k))*rand);
            end
        else
            for k = 1:select.var_num
                cs_new(i,k) = Students(i).mark(k)+((Students(hh).mark(k)-Students(i).mark(k))*rand);
            end
        end      
        cs_new(i,:) = opti_fun_new(select,cs_new(i,:)); %ȷ��û�г��磬������磬ȡ��߽�ֵ
        cs_new_result(i) = result_fun_new(select,cs_new(i,:));%����λ�ú����Ӧ��
        if cs_new_result(i)<Students(i).result  %������ڣ������
            Students(i).mark = cs_new(i,:);
            cs(i,:) = cs_new(i,:);
            Students(i).result = cs_new_result(i);
        end
    end %������Ⱥ����   
    n = length(Students); 
    for i = 1:eliminate %�ﾺ����---eliminate��̭����
        for popindex =(n-(i-1)):select.classsize
            for k=1:select.var_num
                mark(k)=(ll(k))+((ul(k)-ll(k))*rand);
            end
            Students(popindex).mark = mark;
        end
    end
    Students = opti_fun(select,Students);%ȷ���������Ӷ�λ�ڽ�����
    Students = result_fun(select,Students);%��һ������Ⱥ����Ӧֵ
    Students = sortstudents(Students);%��������
    if rand<1 %ȥ���ظ����������ŵ����ӵļ̳��ԣ�û���Ŵ�������
        Students = remove_duplicate(Students,upper_limit,lower_limit);
    end
    Students = sortstudents(Students);%��������
    [average_result,within_bound] = result_avg(Students);%������Ⱥ��ƽ����Ӧ�ȣ�ͼ�Σ�
    min_result = [min_result Students(1).result];%������Ӧ�ȣ�ͼ�Σ�
    avg_result = [avg_result average_result];%�����ϼ�¼��
    Mark = (Students(1).mark);%������Ӧ�ȶ�Ӧ��λ��
    if note1
        %                       disp([num2str(min_result(end))]);%���������̨����
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
fprintf('��%d������', run_time);
fprintf('\n %e',min_result(end));
fprintf('\n %e',avg_result(end)) ;
fprintf('\n %6.10f',Mark);
fprintf('\n ********************** \n');
fprintf('\n %6.10f',FES);
out_put(note1,select,Students,within_bound,min_result);
%����n�����еĹ��̲��ϵ����ģ�������Ӧֵ��ƽ����Ӧֵ ----->Ȼ��ͼ
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
