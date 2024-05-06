clear;close all;
load('D:\Code\Data\1209-ta_data.mat')
load('D:\Code\Data\1209-data_1.mat')

% ref the paper "Identification of behaviours from accelerometer data in a wild social primate", Method :Analyses of acceleration data
% using the dynamic components of the signal (vectorial dynamic body acceleration (VeDBA)) to assess the ‘activity level’ 
% using autocorrelation to access the periodicity of the activity

% the raw data
record_start      = info_xl.StartTime;
record_end        = info_xl.EndTime;
second_interval   = 4;
dateTime_dataT_xl = (datetime(record_start):seconds(second_interval):datetime(record_end))'; 
datemarker        = datevec(dateTime_dataT_xl);
%length(dateTime_dataT_xl)*40 -> size(dataT_xl,1);
disp(record_start);      disp(record_end);
start_time  = [3 10  10 10];% m 
end_time    = [3 10  11 9];

start_month = start_time(1);
start_day   = start_time(2);
start_hour  = start_time(3);
start_minute= start_time(4);

end_month   = end_time(1);
end_day     = end_time(2);
end_hour    = end_time(3)+1;
end_minute  = end_time(4);

% month_startline = find(dt_xl(:,2)==start_month,1);
% month_all       = find(dt_xl(:,2)==start_month);
% day_startline   = find(dt_xl(:,3)==start_day,1);
% day_all         = find(dt_xl(month_all ,3)==start_day);
% hour_startline  = find(dt_xl(day_all,4)==start_hour,1);
% hour_start = day_startline+hour_start-1;27
startline = find(datemarker(:,2)==start_month&datemarker(:,3)==start_day&datemarker(:,4)==start_hour&datemarker(:,5)==start_minute,1);
endline   = (find(datemarker(:,2)==end_month&datemarker(:,3)==end_day&datemarker(:,4)==end_hour-1&datemarker(:,5)==end_minute,1));
% day_end   = find(dt_xl(:,3)==day_end,1);
window   = 100; % in seconds  10HZ
rawdata  = data_xl((startline-1)*40:(endline-1)*40,1:3);% 10 points in 1 second

raw_smooth     = zeros(size(rawdata,1),3);
for jk = 1:3
    raw_smooth(:,jk) = smooth_x(rawdata(:,jk),window);% smooth using 10s window
    disp(jk);
end
% this smooth above take very long time !!! you may would like to save the smoothed data

dba         = rawdata(:,1:3)-raw_smooth;
vdba_raw    = normmmm(rawdata);
vdba_smooth = normmmm(raw_smooth);
vdba        = normmmm(dba);

figure 
subplot(311)
plot(vdba_raw)
subplot(312)
plot(vdba_smooth)
subplot(313)
plot(vdba)
[active_time,sleep_time] = sleep(vdba_raw);


activity = sum(z);
pa       = period_average(x,600);%cut data into 1min window
pa_s     = smooth_x(pa,60);%1hour smooth



figure;
subplot(211)
plot((1:length(pa_s))/(60),pa_s);
xlabel('time (Hour)')
ylabel('VeDBA (m/s2)')
title('Vector danymic body activity ')
subplot(212)
lables={'active','no-active'};
pie([awaketime,sleeptime],lables)

% title('active:no-active percentage')

s_pa_s=(pa_s - nanmean(pa_s)) / nanstd(pa_s);
s_pa_s(isnan(s_pa_s)) = 0;
[autocor,lags] = xcorr(s_pa_s,3*60*24,'coeff');%plot lags in 3 days
figure;
plot(lags/(60*24),autocor)
xlabel('Lag (days)')
ylabel('Autocorrelation')




[H,p,CI] = ttest2(VeDBA_day1 ,VeDBA_day2)











