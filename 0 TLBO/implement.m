%%%%%IMPLEMENT%%%
function[ini_fun,result_fun,result_fun_new,opti_fun,opti_fun_new] = implement
format long
ini_fun = @implementInitialize;
result_fun = @implementresult;
result_fun_new = @implementresult_new;
opti_fun = @implementopti;
opti_fun_new = @implementopti_new;
return;
function [upper_limit,lower_limit,Students,select] = implementInitialize(select)
global lower_limit upper_limit ll ul
Granularity = 1;
lower_limit = ll;
upper_limit = ul;
ll = [78 33 27 27 27];%5维，5个学科，初始化区间
ul = [102 45 45 45 45];
lower_limit = ll;
upper_limit = ul;
%产生一个classize=100的种群，
%Students(1).mark = [ 95 38 29 41 38]
%Students(2).mark = [ 80 38 29 41 38]
%Students(100).mark = [88 38 29 41 38]
    for popindex = 1:select.classsize
          for k=1:select.var_num
              mark(k)=(ll(k))+((ul(k)-ll(k))*rand);
          end
              Students(popindex).mark = mark;
    end
    
         select.OrderDependent = true;
return;
%适应度求取
function [Students] = implementresult(select,Students)
    global lower_limit upper_limit
        classsize = select.classsize;
    for popindex = 1:classsize
        for k=1:select.var_num
            x(k)=Students(popindex).mark(k);
        end
        Students(popindex).result=objective(x);
    end
    return
    %将最优值输入，求取其最新的适应度
    function [Studentss]=implementresult_new(select,Students)
        global lower_limit upper_limit
        classsize =select.classsize;
        for popindex = 1:size(Students,1)
             for k=1:select.var_num
                   x(k)=Students(popindex,k);
             end
             Studentss(popindex)=objective(x);
        end
        return
        
      function[Students]=implementopti(select,Students)
        global lower_limit upper_limit ll ul      
        for i = 1:select.classsize
             for k=1:select.var_num
                    Students(i).mark(k)=max(Students(i).mark(k),ll(k));
                    Students(i).mark(k)=min(Students(i).mark(k),upper_limit(k));
             end     
        end
        return;
        %确保没有出界，如果出界，取其边界值
      function[Students]=implementopti_new(select,Students)
        global lower_limit upper_limit ll ul
        for i = 1:size(Students,1)
             for k=1:select.var_num
                    Students(i,k)=max(Students(i,k),ll(k));
                    Students(i,k)=min(Students(i,k),upper_limit(k));
             end     
        end
        return;
        
        
            



