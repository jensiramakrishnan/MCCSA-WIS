clc;
clear;
close all;

SearchAgents_no = 50;      % Population size
Max_iter = 2000;            % Maximum iterations

% Function_name = 'F1';
% 
% [lb,ub,dim,fobj] = Get_Functions_details(Function_name);
disp_fun;
func_num = input('Select a function:');
D =20;% input('Choose the dimension of the function:');
fhd=str2func('cec22_test_func');
lb=-100;
ub=100;
lb1=-50;
ub1=50;

runtime=30;

FE1 = zeros(1,runtime);
new_f1 = zeros(1,runtime);
tot_time1 = zeros(1,runtime);

SR = 0;
SR1 = 0;

max_it=2000;
limit=25;

cellvalue={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','AA','AB','AC','AD','AE','AF','AG','AH'};
cellvalue=char(cellvalue);
Exs=[cellvalue(func_num,1:end),  num2str(1)];

j=0;


for r=1:1:runtime
[y{r}, new_f1(r), tot_time1(r),val{r},addcavg{r}] =  MCCSAV1(SearchAgents_no,Max_iter,lb,ub,D,fhd,func_num);
sonuclar(r,1)=new_f1(r);
runresult(1:size(val{r},1),r+j:r+j+1)=val{r};
 j=j+1;

end
sonuclar(runtime+2,1)=std(sonuclar);
sonuclar(runtime+1,1)=sum(sonuclar(1:runtime,1))/runtime;
sonuclar(runtime+3,1)=min(sonuclar(1:runtime));
sonuclar(runtime+4,1)=max(sonuclar(1:runtime));
sonuclar(runtime+5,1)=mean(FE1);
dosya=strcat('D:\JENSI\test\MCCSA_WIS\CCSA12022\Results_MCCSA_WIS_Full_Model_V1\MyCCSA','-D',int2str(D),'-it',int2str(max_it),'.xlsx');
xlswrite(dosya,sonuclar,1,Exs);

xlswrite(dosya,{strcat('T: ',num2str(mean(tot_time1)))},1,strcat(Exs,int2str(runtime+5)));
xlswrite(dosya,{strcat('SDT: ',num2str(std(tot_time1)))},1,strcat(Exs,int2str(runtime+6)));

allruns=strcat('D:\JENSI\test\MCCSA_WIS\CCSA12022\Results_MCCSA_WIS_Full_Model_V1\MyCCSA',int2str(func_num),'-D',int2str(D),'allruns','.xlsx');
xlswrite(allruns,runresult,1);

fprintf('Avg. fitness = %1.2e(%1.2e) Avg. FEs = %1.2e(%1.2e) SR = %1.2e\n', mean(new_f1), std(new_f1), mean(FE1), std(FE1), 100*(SR1/runtime));
fprintf('Avg. time = %1.2e(%1.2e)\n', mean(tot_time1), std(tot_time1));

[val1,ind]=min(new_f1);
filename=['D:\JENSI\test\MCCSA_WIS\CCSA12022\Results_MCCSA_WIS_Full_Model_V1\' int2str(func_num) 'D' num2str(D) 'MyCCSA_NFE_BestValue.mat'];
mm=val{ind};
save(filename,'mm');

filename=['D:\JENSI\test\MCCSA_WIS\CCSA12022\Results_MCCSA_WIS_Full_Model_V1\' int2str(func_num) 'D' num2str(D) 'MyCCSA_Iter_BestValue.mat'];
mm1=addcavg{ind};
save(filename,'mm1');