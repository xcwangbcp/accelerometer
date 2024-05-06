
clear;close all;

% filePath_h1 = '\\10.10.44.152\public\005_Data\animal eeg\acc_t\20201023';
% filePath_h1 = '\\10.10.44.152\public\005_Data\animal eeg\acc_t\test_data\20201118-23';
filePath_h1 = '\\10.10.44.152\public\005_Data\animal eeg\acc_t\test_data - 3\20201118-23';

% filePath_h1 = 'D:\00_data\20200401\t1';
% device_name_filter = 'B1A1';%device ID
% device_name_filter = 'F010';%device ID
% device_name_filter = '1218';%device ID
device_name_filter = '11C3';%device ID

matName = 'data_1.mat';

dt_adc = [];
data_adc = [];
dt_xl = [];
data_xl = [];
dt_ba = [];
data_ba = [];
clock_hour = [];

d = dir(filePath_h1);

% length(d)
for jj = 1:length(d)
    
    filePath_h2 = [filePath_h1,'\',d(jj).name];
    
    [ dt_adc_tmp,data_adc_tmp,dt_xl_tmp,data_xl_tmp,dt_ba_tmp,data_ba_tmp,clock_hour_tmp] = step1_fun( filePath_h2 ,device_name_filter);
    if((~isempty(dt_adc_tmp))||(~isempty(dt_xl_tmp)))
        dt_adc =[ dt_adc;dt_adc_tmp];
        data_adc =[ data_adc;data_adc_tmp];
        dt_xl =[ dt_xl;dt_xl_tmp];
        data_xl = [data_xl;data_xl_tmp];
        dt_ba = [dt_ba;dt_ba_tmp];
        data_ba = [data_ba;data_ba_tmp];
        clock_hour = [clock_hour;clock_hour_tmp];
        
        disp(filePath_h2(end-7:end));
    end
    
end


if ~isempty(data_xl)
    
    if ~isempty(data_adc)
        figure;
        plot(data_adc);
        set(gca,'xlim',[0 size(data_adc,1)]);
        
        step2_fun( data_adc );
                
    end
    
    
    %%
    figure;
    hold on;
    for k = 1:size(data_xl,2)
        plot(data_xl(:,k));
    end
    hold off;
    set(gca,'xlim',[0 size(data_xl,1)]);
        set(gcf,'outerposition',get(0,'screensize'));

    %%
    
    earth_gravity = 512;
    xyz = data_xl(:,1:3);
    xyz = xyz./earth_gravity;
    ampl = zeros(size(xyz,1),1);
    for jk = 1:size(xyz,1)
        b = xyz(jk,:);
        ampl(jk) = norm(b);
    end
    
    figure;
    plot(ampl);
    set(gca,'xlim',[0 length(ampl)]);
    title('Amplitude (g)')
    set(gcf,'outerposition',get(0,'screensize'));

    diff_ampl = [0;diff(ampl)];
    [ampl_envelope,~] = envelope(diff_ampl,100,'rms'); % 求包络（阳明大学设备分析方法）
    figure;
    plot(ampl_envelope);
    set(gca,'xlim',[0 length(ampl_envelope)]);
    title('Envelope')
        set(gcf,'outerposition',get(0,'screensize'));

    %%
    %     figure;
    %     plot(clock_hour);
    %     set(gca,'xlim',[0 length(clock_hour)]);
    %     clock_hour_tick = [0 ;diff(clock_hour)];
    
    clock_hour_tick = [0 ;diff(dt_xl(:,4))];
    clock_hour_tick(clock_hour_tick<-1.5) = -1;
    figure;
    plot(clock_hour_tick);
    set(gca,'xlim',[0 size(dt_xl,1)],'xtick',[],'ytick',[]);
    box off;
        set(gcf,'outerposition',get(0,'screensize'));

    %%
    if(~isempty(data_ba))
        
        ba_volt = get_battery_volt_nrf_CR_battery(data_ba);
        
        figure;
        plot(ba_volt);
        set(gca,'xlim',[0 size(ba_volt,1)]);        
    end    
    
    %%
    
    fileNameForSave = [filePath_h1,'\',device_name_filter,'-',matName];
    
    save(fileNameForSave,'data_adc','data_xl','dt_adc','dt_xl','data_ba','dt_ba','clock_hour','-v7.3');
    
    figure_folder = [filePath_h1,'\',device_name_filter,'-figs'];
    mkdir(figure_folder);
    fig_num=0;
    for jj=1:5
        fig_num=fig_num+1;
        saveas(gcf,[figure_folder,'/',num2str(fig_num),'.png']);
        close(gcf);
    end  
    
    align_data_time_fun( filePath_h1,device_name_filter,matName, data_xl,dt_xl);
        
    
end









