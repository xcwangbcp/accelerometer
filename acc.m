%step 0 load in the related data files
clear;
%  load data
[f1,d1] = uigetfile('*.mat','Select Accelerometer Data MAT File:');load([d1,f1]);
[f2,d2] = uigetfile('*.mat','Select Accelerometer Data MAT File:');load([d2,f2]);
% load('F:\Data\accData\120E-data_1.mat');
% load('F:\Data\accData\120E-ta_data.mat');
clear   data_ba data_adc clock_hour dt_ba dt_adc  dt_xl
rawAcc  = dataT_xl;
tAcc    = info_xl.dateTime;
t1      = info_xl.dateTime(1); 
t2      = info_xl.dateTime(end)+seconds(3);
if length(rawAcc)==length(tAcc)*40
    disp('the data is ok for continue analysis')
else
    disp('check the raw data')
    return;
end
clear data_xl dataT_xl  info_xl
% 原始的time中有很多错误，只取第一行数据，后边是每一行人工加了1秒钟,make a timeline

tAcc    = t1:seconds(1):t2;
tAcc    = tAcc';

% set TOI 设置感兴趣的时间，Y/M/D/H/M/S
tSta   = [2021 4 13 18 0   0]; datetSta = datetime(tSta);
tEnd   = [2021 4 13 23 0   0]; datetEnd = datetime(tEnd);
cut    = datefind([datetSta datetEnd], tAcc);
tspan  = tEnd-tSta;
tspan  = tspan(3)*24*60*60+tspan(4)*60*60+tspan(5)*60+tspan(6);%以秒为单位
tpart  = tAcc(cut(1):cut(2));
partAcc= rawAcc((cut(1)-1)*10+1:cut(2)*10,:);% 采样率为10HZ
staticAcc =zeros(length(partAcc),4);
for i=1:4
    if i<4
        partAcc(:,i)  = partAcc(:,i)/512;
        staticAcc(:,i)= smooth(partAcc(:,i),30);% 5 second
    else
        staticAcc(:,i)=partAcc(:,i);
    end
end
dynamicAcc = partAcc-staticAcc;

% tm=length(partAcc)/600;% in minutes
figure
subplot 311
plot(partAcc(:,1),'r');hold on;grid on
plot(partAcc(:,2),'g');
plot(partAcc(:,3),'b');
title('Raw ACC');

subplot 312
plot(staticAcc(:,1),'r');hold on;grid on
plot(staticAcc(:,2),'g');
plot(staticAcc(:,3),'b');
title('Static Acc')

subplot 313
plot(dynamicAcc(:,1),'r');hold on;grid on
plot(dynamicAcc(:,2),'g');
plot(dynamicAcc(:,3),'b');
title('Dynamic Acc')

% set all the parameters for svm
N=length(partAcc);
veDBA = zeros(N,1);
normStatic=zeros(N,1);
pitch = zeros(N,1);
roll  = zeros(N,1);
yaw   = zeros(N,1);  
for i=1:N
    veDBA(i) = norm(dynamicAcc(i,1:3));
    normStatic(i)=norm(staticAcc(i,1:3));
    pitch(i) = asind(staticAcc(i,1)/normStatic(i));
    roll(i)  = asind(staticAcc(i,2)/normStatic(i));
    yaw(i)   = asind(staticAcc(i,3)/normStatic(i));
end 
veDBAs       = smooth(veDBA,30);
pDBA         = abs(dynamicAcc(:,1:3));
ratioDBA     = pDBA./veDBA;

PSD=zeros(N,3);
fs           = 10;
t            = 1:1:N;
fft_accx     = fft(dynamicAcc(:,1));
fft_accy     = fft(dynamicAcc(:,2));
fft_accz     = fft(dynamicAcc(:,3));

% fft_acc=fft_acc(1:N/2+1);
PSD(:,1)     = (1/(fs*N))*abs(fft_accx).^2;
PSD(:,2)     = (1/(fs*N))*abs(fft_accy).^2;
PSD(:,3)     = (1/(fs*N))*abs(fft_accz).^2;

% psd_acc(2:end-1)=2*psd_acc(2:end-1);
freq   = 0:fs/N:fs;
freq   = freq(1:end-1);
plot(freq,(PSD(:,3)));
grid on
title("Periodogram Using FFT");
xlabel("Frequency (Hz)")
ylabel("Power/Frequency (dB/Hz)")





% ss=cell(225890,1);
% for i=1:225891
%     if i<225891
%         s=between(datetime(dt_xl(i,:)),datetime(dt_xl(i+1,:)),'Time');
%         ss{i}=string(s);% 原时间数据会有6%的错误，相邻两个时间的秒数差不等于4，常发生在日期+1的位置
%         % zz(i)=contains(ss{i,1},'0h 0m 4s');
%     end
% end
% step 1,compress the data into 1 HZ sample rate       % sample rate=10HZ
% [s1,~]         = size(data_xl);
% tExpand=zeros(s1/10,6);
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





% get the original time sequence from the dt_xl,and put the empty time with
% zeros



pDBA         = abs(segementData);




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
