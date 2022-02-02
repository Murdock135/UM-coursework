clear all; close all;

[y, Fs] = audioread('17143014_filtered.wav');

%Obtaining the characteristics of the signal
N = length(y);
n = 0:N-1;
Ts = 1/Fs;
t = n.*Ts;

k = n;
Y = fft(y); %performing DFT
fhz = k/(N*Ts);

figure(1)
plot(fhz(1:length(n)/2),abs(Y(1:length(n)/2))) %plotting only half of the samples
figure(2)
plot(log10(abs(Y)))
title('Log scale')

%reshaping the matrix of audio samples
W = 1000;
reshaped_Y = reshape(Y, W, []);

%bandwidth of one window
k = 0:W-1;
fhz = k/(W*Ts);


%calculating window size in [s]
number_of_windows = length(reshaped_Y);
total_time = number_of_windows*W*Ts
Tw = (1:size(reshaped_Y,2))*W*Ts; %size of window in seconds


%time[s] vs f[hz] vs magnitude plot
figure(3)
mesh(Tw, fhz, 20*log10(abs(reshaped_Y)))
xlabel('seconds')
ylabel('Hz')
view(0,90)

%plotting only half of the bandwidth
% k = k(1:length(k)/2);
% fhz = k/(W*Ts);
% Tw = (1:size(reshaped_Y,2))*W*Ts; %size of window in seconds
figure(4)
mesh(Tw, fhz(1:W/2), 20*log10(abs(reshaped_Y(1:W/2,:))))
xlabel('seconds')
ylabel('Hz')


%filtering noise
f1 = 2e5;
f2 = 6e5;
Y(f1:f2)=0;

figure('Name','Filtered')
plot(log(abs(Y)))

%inverse FT
y = ifft(Y);
plot(t,y)

