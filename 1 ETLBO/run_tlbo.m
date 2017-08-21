%%%%%%%RUNTLBO%%%%%
function run_tlbo()
clear %±äÁ¿Çå³ý
clc;
run=30;
global     FES  run_time ;%FES_etlbo min_etlbo avg_etlbo diedai time_etlbo ;
% min_etlbo=zeros(1,diedai);
% avg_etlbo=zeros(1,diedai);
% time_etlbo=zeros(1,diedai);
% FES_etlbo=zeros(1,diedai);
format long;
for i=1:run
    FES=0;
    run_time=i;
    TLBO(@implement);
end