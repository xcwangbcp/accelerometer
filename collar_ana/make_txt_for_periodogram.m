filePath_h1 = '\\10.10.44.152\public\005_Data\animal eeg\acc_t\test_data - 3\20201118-23';

device_name_filter = '11C3';%device ID

matName = 'vdba.mat';

fileNameForSave = [filePath_h1,'\',device_name_filter,'-',matName];

load(fileNameForSave);

pa_6min=period_average(vdba,3600);%cut data into 6min window, 6min from the parameter of "tau.exe" software 

T = table(pa_6min);
% Write data to text file
txtfile=[filePath_h1,'\',device_name_filter,'-d_peri.txt'];
writetable(T, txtfile);



