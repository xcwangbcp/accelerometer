filepathname = 'C:\Users\Administrator\Desktop\Periodograms\result.txt';
aa = readtable(filepathname);
d=table2array(aa(2:end,2));
t=table2array(aa(2:end,1));
plot(t,d);