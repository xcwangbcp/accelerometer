function  align_data_time_fun_3( filePath_ana_mat,device_name_filter,matName,data_xl,dt_xl )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% modify from align_data_time_fun_2, use data_xl,dt_xl as input, do not
% need to load the mat

% fileNameFor_load = [filePath_ana_mat,'\',device_name_filter,'-',matName];

% filePath_h1 = 'C:\Users\Administrator\Desktop\data-2'; 
% device_name_filter = '1205';%device ID 
% matName = 'data_1.mat';

% load(fileNameFor_load);

% some test
% data_xl=[data_xl;data_xl(1:40,:)];
% dt_xl=[dt_xl;[2020,12,4,18,2,24]];
%
% data_xl(13601:13880,:)=[];
% dt_xl(201:207,:)=[];

if(size(data_xl,1)/size(dt_xl,1)~=40)
    error('check data---xkw');
end

second_interval=4;
day2second_num =24*60*60;
ta=datetime(dt_xl);
t2=datenum(ta);
a_elapsed=(t2-t2(1))*day2second_num;
te = ta(1):seconds(second_interval):ta(end);
e_elapsed=((datenum(te)-datenum(te(1)))')*day2second_num;

packet_num=length(te);
dataT_xl = zeros(packet_num*40,4);

nan_data=zeros(40,4);
nan_data(:,:)=NaN;

len_a_elapsed=length(a_elapsed);
sync_flag_error=0;
missing_packet = zeros(packet_num,1);
jj=1;
for jk = 1:packet_num
    if(jj>len_a_elapsed)
        dataT_xl((jk-1)*40+1:end,:)=NaN;%fill all the last as NaN
        break;
    end
    tmp=abs(a_elapsed(jj)-e_elapsed(jk));
    tmp_error_flag=0;
    fill_in=1;
    if sync_flag_error==0
        thr_num=20;
        if(tmp>thr_num)
            if(jj+5>len_a_elapsed)
                sync_flag_error=1;
            else
                if abs(a_elapsed(jj+5)-e_elapsed(jk+5))>thr_num
                    sync_flag_error=1;
                    tmp_error_flag=1;
                end
            end
        end
    else
        thr_num=4;
        if(tmp>thr_num)
            tmp_error_flag=1;   %  not catch up, or still ahead
        else
            sync_flag_error=0;
        end
    end
    
    if  tmp_error_flag==1
        if (a_elapsed(jj)-e_elapsed(jk))>thr_num
            fill_in=2;    % fill with NaN
        else
            fill_in=0;  %delete this data packet
        end
    end
    
    if fill_in==1
        dataT_xl((jk-1)*40+1:jk*40,:)=data_xl((jj-1)*40+1:jj*40,:);
        jj=jj+1;
    elseif fill_in==2
        dataT_xl((jk-1)*40+1:jk*40,:)=nan_data;
        missing_packet(jk)=1;
    else
        jj=jj+1;
    end    
end


fileNameForSave = [filePath_ana_mat,'\',device_name_filter,'-ta_data.mat'];
    

missing_packet_num=find(missing_packet);

dateTime_dataT_xl = (te(1):seconds(second_interval):te(end))'; %length(dateTime_dataT_xl)*40 -> size(dataT_xl,1);

info_xl.StartTime=datevec(te(1));
info_xl.EndTime=datevec(te(end));
info_xl.dateTime=dateTime_dataT_xl;
info_xl.SampleRate='10Hz';
info_xl.SampleNumPerPacket=40;
info_xl.PacketNum=packet_num;
info_xl.MissingPacketNum=length(missing_packet_num);
info_xl.MissingPackets=missing_packet_num;
info_xl.MissRate=length(missing_packet_num)/packet_num;

% dateTime_dataT_xl = (datetime(info_xl.StartTime):seconds(second_interval):datetime(info_xl.EndTime))'; %length(dateTime_dataT_xl)*40 -> size(dataT_xl,1);


save(fileNameForSave,'dataT_xl','info_xl','-v7.3');
    


end



