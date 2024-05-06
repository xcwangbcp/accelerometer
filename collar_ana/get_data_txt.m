function  [dt_adc,adc_data,dt_xl,xl_data,dt_ba,ba_data] = get_data_txt(fileName,device_name_num)

%增加读取年月日的功能

xl_data = [];
adc_data = [];
ba_data = [];
dt_xl = [];
dt_adc = [];
dt_ba = [];

if_exist = exist(fileName,'file');
if(if_exist == 0)
    return;
end

packet_len = 250;
data_adc_len_packet = 160; %一个包解压之后，应该有160个 16位 adc数据
data_xl_len_packet = 40;  %一个包解压之后，应该有40组（一组xyzt） 16位 xl数据

compressed_group_num = 80;
compressed_data_len = 3;

% fileName = [folderName,'/',txtName];

fileID = fopen(fileName);
A = fread(fileID);
% A(1:1640) = [];
fclose(fileID);

if(rem(size(A,1),2)~=0)
    disp(fileName);
    disp(size(A,1));
    disp('file error---xkw');
    return;
end


if(rem(size(A,1),packet_len)~=0)
    disp(fileName);
    disp(size(A,1));
    disp('file error---xkw');
    return;
end


flag_ba = 1;
flag_xl = 2;
flag_adc = 5;
flag_index = 6;
flag_txt_header = 9;

device_num_index_1 = 7;
device_num_index_2 = 8;

dt_xl_tmp = [];
dt_adc_tmp = [];

tmp301=zeros(4,1);

if A(6)== flag_txt_header
    tmp_file_header = A(9:12);
            dt_32b_file_header = typecast(uint8(tmp_file_header), 'UINT32');
        dt_tmp_file_header = get_dt(dt_32b_file_header);
end
A = A(251:end);
    
if(~exist('dt_tmp_file_header','var'))
    disp(fileName);
    warning('this file has no file_header,check---xkw');
    return
end


packet_num = length(A)/packet_len;


tmp_xl = [];
tmp_adc = [];
for jk = 1:packet_num
    
    tmp = A((jk-1)*packet_len+1:jk*packet_len);
    
    tmp2 = tmp(9:10);
    dt_16b = typecast(uint8(tmp2), 'UINT16');
    dt_tmp = get_dt_16b(dt_16b);
    dt_tmp(1:3)=dt_tmp_file_header(1:3);
    %     dt_32b = typecast(uint8(tmp2), 'UINT32');
    %     dt_tmp = get_dt(dt_32b);
    %     T = struct2table(dt_tmp);
    %     dt(jk,:) = T;
    
    if((tmp(device_num_index_1)~=device_name_num(1))|| (tmp(device_num_index_2)~=device_name_num(2)) )
       continue; 
    end
    
    if(tmp(flag_index) == flag_xl) %xl data
        dt_xl_tmp = [dt_xl_tmp;dt_tmp];
    end
    if(tmp(flag_index) == flag_adc) %adc data
        dt_adc_tmp = [dt_adc_tmp;dt_tmp];
    end
       
    if(tmp(flag_index) == flag_ba) %ba data
%         dt_ba = [dt_ba;dt_tmp];     
%         ba_data = [ba_data;tmp(7)];
                ba_data = [ba_data;tmp(11)];%20200625,change to 11

        continue;
    end
    
    tmp3 = tmp(11:end);
    tmp4 = [];
    for jj = 1:compressed_group_num
        tmp33 = tmp3((jj-1)*compressed_data_len+1:jj*compressed_data_len);
        tmp301(1) = uint8(tmp33(1));
        tmp301(3) = uint8(tmp33(3));
        if(tmp(flag_index) == flag_adc) %adc data
            tmp331 = tmp33(2);
            tmp301(2) = bitand(tmp331,15);
            tmp301(4) = bitand(bitshift(tmp331,-4),15);
        end
        if(tmp(flag_index) == flag_xl) %adc data
            tmp331 = tmp33(2);
            if(bitand(tmp331,8)==8);
                tmp301(2) = bitor(bitand(tmp331,15),240);
            else
                tmp301(2) = bitand(tmp331,15);
            end
            
            tmp3312 = bitshift(tmp331,-4);
            if(bitand(tmp3312,8)==8);
                tmp301(4) = bitor(bitand(tmp3312,15),240);
            else
                tmp301(4) = bitand(tmp3312,15);
            end
        end
        
        tmp31= reshape(tmp301,2,2);
        tmp311 = uint8(tmp31(:,1));
        tmp312 = uint8(tmp31(:,2));
        tmp321 = typecast(tmp311, 'INT16');
        tmp322 = typecast(tmp312, 'INT16');
                
        tmp4 =  [tmp4;tmp321;tmp322];
        
    end
    
    
    if(tmp(flag_index) == flag_xl) %xl data
        tmp_xl = [tmp_xl;tmp4];
    end
    if(tmp(flag_index) == flag_adc) %adc data
        tmp_adc = [tmp_adc;tmp4];
    end
    
    
end
z = reshape(tmp_xl,4,size(tmp_xl,1)/4);

%
% figure;
% hold on;
% for k = 1:size(z,1)
%
%     plot(z(k,:));
%
% end
% hold off;
% figure;
% plot(z(4,:));



% name_for_save = [folderName,'/',txtName(1:3),'_dt_z.mat'];
% save(name_for_save,'dt','z');

see_if_data_length_correct = size(dt_xl_tmp,1)*data_xl_len_packet;
if(see_if_data_length_correct~=size(z,2))
    return;
end
see_if_data_length_correct_2 = size(dt_adc_tmp,1)*data_adc_len_packet;
if(see_if_data_length_correct_2~=size(tmp_adc,1))
    return;
end

xl_data = z';
adc_data = tmp_adc;
dt_xl = dt_xl_tmp;
dt_adc = dt_adc_tmp;


% see_if_data_length_correct2 = see_if_data_length_correct/4;

end


function [ dt ] = get_dt( dt_32b )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

e = bitshift(dt_32b,-25);

f = bitshift(dt_32b,-21);

ff = bitand(f,15);

g = bitshift(dt_32b,-16);

gg = bitand(g,31);

h = bitshift(dt_32b,-11);

hh = bitand(h,31);

i = bitshift(dt_32b,-5);

ii = bitand(i,63);

j = bitand(dt_32b,31);

jj = bitshift(j,1);

%
% dt.year = e+1980;
% dt.month = ff;
% dt.day = gg;
% dt.hour = hh;
% dt.minute = ii;
% dt.second = jj; % 结构体计算速度可能比较慢 不用了 用vector

dt = zeros(1,6);
% dt(1) = e+1980;
dt(1) = e+2000; %if the ble_ctrl use stm32-rtc time,the year reperensent the ones place and tens place of the number, for example: 1988 will be 88



dt(2) = ff;
dt(3) = gg;
dt(4) = hh;
dt(5) = ii;
dt(6) = jj;



end


function [ dt ] = get_dt_16b( dt_32b )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明


h = bitshift(dt_32b,-11);

hh = bitand(h,31);

i = bitshift(dt_32b,-5);

ii = bitand(i,63);

j = bitand(dt_32b,31);

jj = bitshift(j,1);

%
% dt.year = e+1980;
% dt.month = ff;
% dt.day = gg;
% dt.hour = hh;
% dt.minute = ii;
% dt.second = jj; % 结构体计算速度可能比较慢 不用了 用vector

dt = zeros(1,6);
dt(1) =0;
dt(2) = 0;
dt(3) = 0;
dt(4) = hh;
dt(5) = ii;
dt(6) = jj;



end
