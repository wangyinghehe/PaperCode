%%%%%%%RUNTLBO%%%%%
function run_tlbo()
clear %±äÁ¿Çå³ý
clc;
run=30;
global FES  run_time ;%time_tlbo FES_tlbo min_tlbo avg_tlbo diedai ;
%     min_tlbo=zeros(1,diedai);
%     avg_tlbo=zeros(1,diedai);
%     time_tlbo=zeros(1,diedai);
%     FES_tlbo=zeros(1,diedai);
format long;
for i=1:run
    FES=0;
    run_time=i;
    TLBO(@implement);
end