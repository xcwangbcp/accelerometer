filePath_h1 = '\\10.10.44.152\public\005_Data\animal eeg\acc_t\test_data - 3\20201118-23';

device_name_filter = '11C3';%device ID

matName = 'vdba.mat';

fileNameForLoad = [filePath_h1,'\',device_name_filter,'-ta_data.mat'];

load(fileNameForLoad);

% load('\\10.10.44.152\public\005_Data\animal eeg\acc_t\test_data - 3\20201118-23\11C3-ta_data.mat')

% ref the paper "Identification of behaviours from accelerometer data in a wild social primate", Method :Analyses of acceleration data
% using the dynamic components of the signal (vectorial dynamic body acceleration (VeDBA)) to assess the ‘activity level’
% using autocorrelation to access the periodicity of the activity

close all;
xl_s=zeros(size(dataT_xl,1),3);
for jk = 1:3
    xl_s(:,jk)=smooth_x(dataT_xl(:,jk),100);% smooth using 10s window
    disp(jk);
end
% this smooth above take very long time !!! you may would like to save the smoothed data

dba=dataT_xl(:,1:3)-xl_s;

vdba = zeros(size(dba,1),1);%(VeDBA)

for jk = 1:size(dba,1)
    tmp = dba(jk,:);
    vdba(jk) = norm(tmp)/512;
end

pa = period_average(vdba,600);%cut data into 1min window

pa_s=smooth_x(pa,60);%1hour smooth

figure;
plot((1:length(pa_s))/(60*24),pa_s);
xlabel('time (days)')
ylabel('VeDBA (m/s2)')

s_pa_s=(pa_s - nanmean(pa_s)) / nanstd(pa_s);
s_pa_s(isnan(s_pa_s)) = 0;
[autocor,lags] = xcorr(s_pa_s,3*60*24,'coeff');%plot lags in 3 days
figure;
plot(lags/(60*24),autocor)
xlabel('Lag (days)')
ylabel('Autocorrelation')


fileNameForSave = [filePath_h1,'\',device_name_filter,'-',matName];

save(fileNameForSave,'vdba','-v7.3');






