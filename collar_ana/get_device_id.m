clear;
file_path='\\10.10.44.152\public\005_Data\animal eeg\acc_t\test_data - 3\20201118-23\11181524';
file_name='A_0.TXT';
filePathName = fullfile(file_path,file_name);
fileID = fopen(filePathName);
A = fread(fileID);
fclose(fileID);

packet_len = 250;
data_adc_len_packet = 160; %一个包解压之后，应该有160个 16位 adc数据
data_xl_len_packet = 40;  %一个包解压之后，应该有40组（一组xyzt） 16位 xl数据

compressed_group_num = 80;
compressed_data_len = 3;

% fileName = [folderName,'/',txtName];

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
end
A = A(251:end);


packet_num = length(A)/packet_len;

name_s=[];
for jk = 1:packet_num
    
    tmp = A((jk-1)*packet_len+1:jk*packet_len);
       
    name_s=[name_s,tmp(device_num_index_1:device_num_index_2)];
    
end

for jj = 1:size(name_s,2)   
    tmp=[name_s(1,jj);name_s(2,jj)];
    tmp2 = dec2hex(tmp);
    tmp3 = [tmp2(2,:),tmp2(1,:)];
    
     name_hex(jj,:) = {(tmp3)};
end

name_unique= unique(name_hex);

for kk=1:length(name_unique)
    disp(cell2mat(name_unique(kk)));
end





