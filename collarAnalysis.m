clear;close all 
load('D:\Code\collarData\sd_1\03130353\1209-data_1.mat')
earth_gravity = 512;
xyz = data_xl(:,1:3);
xyz = xyz./earth_gravity;
ampl = zeros(size(xyz,1),1);
    for jk = 1:size(xyz,1)
        b = xyz(jk,:);
        ampl(jk) = norm(b);
    end
day = 5;
second = day*24*60*60*10;
ampl   = ampl(1:second);    
figure 
plot(ampl);
Fs   = 36000; %into hour  
% Fs   = 600; % into minutes
rawL = length(ampl);
yushu = mod(rawL,Fs);
if  yushu>0
    ampl = ampl(1:rawL-yushu);
    Num_h = (rawL-yushu)/Fs;
end

squeeData = mean(reshape(ampl,Fs,length(ampl)/Fs));
figure
plot(squeeData)
figure
hist(squeeData)
figure
scatter(1:1:length(squeeData),squeeData)
X = ampl;
X= pa_s;
Fs = 10;
T = 1/Fs;       % Sampling period 
L = length(X);
% L = height(X);  % Length of signal
t = (0:L-1)*T; % Time vector 

% plot(t,X,'b');
% title('Monkey 133 right foot X-dimension move')
% xlabel('t(s)')
% ylabel('X(pixle)')
% X = table2array(X);
% X   = X-mean(X);
X = smooth(X);
% X = detrend(X);
F_X = fft(X);
P2 = abs(F_X/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
8
figure
plot(f,P1)