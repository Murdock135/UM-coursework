clear all; close all;


[x, Fs] = audioread('17143014_noisy.wav');

%Obtaining the characteristics of the signal
N = length(x);
n = 0:N-1;
Ts = 1/Fs;
t = n.*Ts;

k = n;
X = fft(x); %performing DFT
fhz = k/(N*Ts);

figure(1)
plot(fhz(1:length(n)/2),abs(X(1:length(n)/2))) %plotting only half of the samples
title('Unfiltered ')
xlabel('hz')
ylabel('Magnitude')
%% Precomputing the specifications and the order
%observing the graph, the stop frequency (discrete) is 1.3e4 Hz

discrete_stop = 1.3e4*2*pi;
discrete_cutoff = 9530*2*pi;
%prewarping
analog_stop = 2/Ts*tan((discrete_stop*Ts)/2)
analog_cutoff = 2/Ts*tan((discrete_cutoff*Ts)/2)

stop_ripple = 0.1;
order = ceil((log10(1/stop_ripple^2-1))/(2*log10(analog_stop/analog_cutoff)));
order = order+1; %just in case 5 isn't good enough

%% Computing the coeffs

A = tan((discrete_cutoff*Ts)/2);

%calculating the coefficients (for the H(s) for the 
%analog prototype
b1 = 3.8637/A;
b2 = 7.464/A^2;
b3 = 9.1416/A^3;
b4 = 7.4641/A^4;
b5 = 3.8637/A^5;
b6 = 1/A^6;


%confirming correctness of coefficients found manually in report
% with butter()
[b, a] = butter(6,9530/(Fs/2));

%% Filtering the signal

%obtaining the filtered signal
filteredSignal = filter(b, a, x);
audiowrite('170724_filtered.wav',filteredSignal,Fs)%save the filtered audio to computer
Y = fft(filteredSignal);

%Plotting the filtered signal
figure(2)
plot(fhz(1:length(n)/2),abs(Y(1:length(n)/2))) %plotting only half of the samples
xlabel('hz')
ylabel('Magnitude')
title('Filtered')

%% Plotting the magnitude vs frequency vs Time

[y, Fs] = audioread('17143014_filtered.wav');
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
%% Plotting the magnitude frequency response

rad = fhz.*2*pi;

syms z
H = (0.0096*z^-6 + 0.0598*z^-5 + 0.149*z^-4 + 0.199*z^-3 + 0.149*z^-2 + 0.0598*z^-1 + 0.0096)/(1 - 1.222*z^-1 + 1.337*z^-2 - 0.701*z^-3 +0.273*z^-4 - 0.054*z^-5 + 0.0054*z^-6);

%the following line is commented out because the operation is computationally too expensive
%freq_domain = subs(H, exp(1i*rad));

%the following code does not work
%sys = tf([0.0096 0.0598 0.149 0.199 0.149 0.0598 0.0096], [1 -1.222 1.337 -0.701 0.273 -0.054  0.00524],[Ts],'Variable', 'z^-1');
%figure('Name','Magnitude frequency response')
%bode(sys)




