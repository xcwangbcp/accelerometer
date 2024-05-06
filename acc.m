%step 0 load in the related data files
clear;
[f1,d1] = uigetfile('*.mat','Select Accelerometer Data MAT File:');
load([d1,f1]);
[f2,d2] = uigetfile('*.mat','Select Accelerometer Data MAT File:');
load([d2,f2]);
% load('F:\Data\accData\120E-data_1.mat');
% load('F:\Data\accData\120E-ta_data.mat');

% ss=cell(225890,1);
% for i=1:225891
%     if i<225891
%         s=between(datetime(dt_xl(i,:)),datetime(dt_xl(i+1,:)),'Time');
%         ss{i}=string(s);% 原时间数据会有6%的错误，相邻两个时间的秒数差不等于4，常发生在日期+1的位置
%         % zz(i)=contains(ss{i,1},'0h 0m 4s');
%     end
% end
% step 1,compress the data into 1 HZ sample rate       % sample rate=10HZ
[s1,~]         = size(data_xl);
zipAccData     = zeros(s1/10,4); % take the mean of the 10 samples
for i=1:s1/10
    zipAccData(i,1:3)=mean(data_xl((i-1)*10+1:i*10,1:3))/512;
    % zipAccData(i,4)  =mean(data_xl((i-1)*10+1:i*10,4));
end


% get the original time sequence from the dt_xl,and put the empty time with
% zeros

tExpand=zeros(s1/10,6);
% 取原数据中给出的每隔4秒1次的数据，原数据会有误差
% for j=1:s1/10
%      if rem(j,4)==1
%         tExpand(j,:) = tse(round(j/4)+1,:);
%         t1=datetime(tExpand(j,:),'InputFormat','yyyy-MM-dd hh:mm:ss');
%         t2=t1+seconds(1);
%         % datenum_t2=datenum(t2);
%         tExpand(j+1,:)=[year(t2) month(t2) day(t2) hour(t2) minute(t2) second(t2)];
%         t3=t1+seconds(2);
%         tExpand(j+2,:)=[year(t3) month(t3) day(t3) hour(t3) minute(t3) second(t3)];
%         t4=t1+seconds(3);
%         tExpand(j+3,:)=[year(t4) month(t4) day(t4) hour(t4) minute(t4) second(t4)];
%      end
% end
% 只取第一行数据，后边是每一行人工加了1秒钟
tExpand(1,:) = dt_xl(1,:);
tbegin       = datetime(tExpand(1,:),'InputFormat','yyyy-MM-dd hh:mm:ss');
for  j   = 2:s1/10
     tse = tbegin+seconds(j-1);
     tExpand(j,:)=[year(tse) month(tse) day(tse) hour(tse) minute(tse) second(tse)];
end
time_text          = datetime(tExpand,'InputFormat','yyyy-MM-dd hh:mm:ss');
time_text.TimeZone = "local";% t=posixtime(time);
tStart=[2021 4 13 19 0 0];
tEnd  =[2021 4 14  0 0 0];

s_cut=find(tExpand(:,2)==tStart(2)&tExpand(:,3)==tStart(3)&...
    tExpand(:,4)==tStart(4)&tExpand(:,5)==tStart(5)&tExpand(:,6)==tStart(6));
e_cut=find(tExpand(:,2)==tEnd(2)&tExpand(:,3)==tEnd(3)&...
    tExpand(:,4)==tEnd(4)&tExpand(:,5)==tEnd(5)&tExpand(:,6)==tEnd(6));
% [s_cut e_cut]=segment(tExpand,t_start,t_end);
segementData=[zipAccData(s_cut:e_cut,:)];

filename_mat= [d1 'saveAccData\' f1(1:4) '—segment.mat'];
% 'F:\Data\accData\saveData\120E—segment.mat';
save(filename_mat,"segementData")
%acc_x = zipAccData(:,1);acc_y = zipAccData(:,2);acc_z = zipAccData(:,3);
% save the time and acc data into a file
filename_csv = [d1 'saveAccData\' f1(1:4) '—.csv'];
%'F:\Data\accData\saveData\120E.csv';
% Nline=193681;mymatrix = table(time(1:Nline),acc_x(1:Nline),acc_y(1:Nline),acc_z(1:Nline));
% mymatrix = table(time_text(1:end),zipAccData(:,1),zipAccData(:,2),zipAccData(:,3),zipAccData(:,4));
% writetable(mymatrix,filename_csv);
% xlswrite(mymatrix,filename)




% function timechange
% for j=1:s1/10
%      if rem(j,4)==1
%         tExpand(j,:) = t(round(j/4)+1,:);
%         t_s          = tExpand(j,end);
%         t_m          = tExpand(j,end-1);
%         t_h          = tExpand(j,end-2);
%         t_d          = tExpand(j,3);
%         t_M          = tExpand(j,2);
%         t_y          = tExpand(j,1);
%         if t_s<=56
%             % if second count less than 58, copy the first 5 collums ymdhm
%             tExpand(j+1,1:5) = tExpand(j,1:5);
%             tExpand(j+2,1:5) = tExpand(j,1:5);
%             tExpand(j+3,1:5) = tExpand(j,1:5);
%             % and add one sequencely,second +1
%             tExpand(j+1,end) = tExpand(j,end)+1;
%             tExpand(j+2,end) = tExpand(j,end)+2;
%             tExpand(j+3,end) = tExpand(j,end)+3;
%         elseif t_s==57
%              % if second count=57, copy the first 5 collums for
%              % j+1 
%             tExpand(j+1,1:5) = tExpand(j,1:5);
%             tExpand(j+1,end) = 58;
%             % for j+2/j=3 rows,the last one should be 0/1,the end-1 will
%             % increase one, and 1:4 will be the same as row j
%             % j+2
%             tExpand(j+2,1:5)   = tExpand(j,1:5);
%             tExpand(j+2,end)   = 59;
%             % j+3
%             tExpand(j+3,end)   = 0;
%             if  t_m<=58
%                 tExpand(j+3,5)     = tExpand(j,5)+1;
%                 tExpand(j+3,1:4)   = tExpand(j,1:4);
%             elseif t_m==59
%                 tExpand(j+3,5)     = 0;
%                 if t_h<23
%                     tExpand(j+3,4)   = tExpand(j,4)+1;
%                     tExpand(j+3,1:3) = tExpand(j,1:3);
%                 else
%                     tExpand(j+3,4)   = 0;
%                     tExpand(j+3,3)   = tExpand(j,3)+1;%%%这里涉及到天增加1的时候，概率较低暂不考虑
%                     tExpand(j+3,1:2) = tExpand(j,1:2);
%                 end
%             end         
%         elseif t_s==58
%             tExpand(j+1,1:5)   = tExpand(j,1:5); 
%             tExpand(j+1,end)   = t_s+1;
%             tExpand(j+2,end)   = 0;
%             tExpand(j+3,end)   = 1;
% 
%             if t_m<=58
%                 tExpand(j+2,1:4) = tExpand(j,1:4)+1;
%                 tExpand(j+3,1:4) = tExpand(j,1:4)+1;
%                 tExpand(j+2,5)   = tExpand(j,5)+1;
%                 tExpand(j+3,5)   = tExpand(j,5)+1;
%             else
%                 tExpand(j+2:j+3,5)   = 0;
%                 if t_h<23
%                     tExpand(j+2,4)   = tExpand(j,4)+1;
%                     tExpand(j+3,4)   = tExpand(j,4)+1;
%                     tExpand(j+2,1:3) = tExpand(j,1:3);
%                     tExpand(j+3,1:3) = tExpand(j,1:3);
%                 else
%                     tExpand(j+2,4)   = 0;
%                     tExpand(j+3,4)   = 0;
%                     tExpand(j+2,3)   = tExpand(j,3)+1;%%%这里涉及到天增加1的时候，概率较低暂不考虑
%                     tExpand(j+3,3)   = tExpand(j,3)+1;
%                     tExpand(j+2,1:2) = tExpand(j,1:2);
%                      tExpand(j+3,1:2)= tExpand(j,1:2);
%                 end
%             end
% 
%         elseif t_s==59
%             tExpand(j+1,6)     = 0;
%             tExpand(j+2,6)     = 1;
%             tExpand(j+3,6)     = 2;
%              if t_m<=58
%                  tExpand(j+1,5)     = tExpand(j,5)+1;
%                  tExpand(j+2,5)     = tExpand(j,5)+1;
%                  tExpand(j+3,5)     = tExpand(j,5)+1;
%                  tExpand(j+1,1:4)   = tExpand(j,1:4);
%                  tExpand(j+2,1:4)   = tExpand(j,1:4);
%                  tExpand(j+3,1:4)   = tExpand(j,1:4);
%             else
%                 tExpand(j+1:j+3,5)   = 0;
%                 if t_h<23
%                 tExpand(j+2:j+3,4)   = tExpand(j,4)+1;
%                 tExpand(j+2:j+3,1:3) = tExpand(j,1:3);
%                 else
%                     tExpand(j+1:j+3,4)   = 0;
%                     tExpand(j+1:j+3,3)   = tExpand(j,3)+1;
% 
%                 end
%             end
%         end
%      end
% end
% end
% function [s,e]=segment(t)
% 
% 
% end
