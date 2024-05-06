function [ dt_adc,data_adc,dt_xl,data_xl,dt_ba,data_ba, clock_hour] = step1_fun( filePath_h1 ,device_name_filter)

expected_file_num = 1000;

%%
mice_name_filter = 'A_';

device_name_1 = (device_name_filter(1:2));
device_name_2 = (device_name_filter(3:4));
device_name_num = [hex2dec(device_name_2),hex2dec(device_name_1)];

dt_adc = [];
data_adc = [];
dt_xl = [];
data_xl = [];
dt_ba = [];
data_ba = [];
clock_hour = [];

for h1 = 1:expected_file_num
    fileName = [mice_name_filter,num2str(h1-1),'.txt'];
    filePathName = [filePath_h1,'\',fileName];
    
    [dt_adc_tmp,data_adc_tmp,dt_xl_tmp,data_xl_tmp,dt_ba_tmp,data_ba_tmp] = get_data_txt(filePathName,device_name_num);
    
    if((~isempty(dt_adc_tmp))||(~isempty(dt_xl_tmp)))
        dt_adc =[ dt_adc;dt_adc_tmp];
        data_adc =[ data_adc;data_adc_tmp];
        dt_xl =[ dt_xl;dt_xl_tmp];
        data_xl = [data_xl;data_xl_tmp];
        dt_ba = [dt_ba;dt_ba_tmp];
        data_ba = [data_ba;data_ba_tmp];
        
        fileStruct = dir([filePath_h1 '\*' fileName]);
        
%         if(isempty(fileStruct.date))            
%             1            
%         end
        datevec_tmp = datevec(fileStruct.date);
        
%         clock_hour_tmp = ones(size(data_xl_tmp,1),1)*datevec_tmp(4);
%         clock_hour = [clock_hour;clock_hour_tmp];
        
    end
end


data_adc = double(data_adc);
data_xl = double(data_xl);


end

