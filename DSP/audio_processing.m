clear all; close all;

total_time = 0.01;
f = 500;

Fs = 44.1e3; %sampling frequency
T = 1/Fs; %sampling interval
n = 0:total_time/T-1; %number of sample
t = n*T;

y = sin(2*pi*f*n*T); %this should be replaced by the difference equation of the sound file

plot(t,y)
%sound(y, Fs) %DO NOT PLAY WITH HIGH VOLUME

%%
%DFT
N = length(t);
k = 0:N-1;

sound_repeated = repmat(y,N,1);
Y = sum(exp(-1i*2*pi*k'.*k./N).*sound_repeated,2);

plot(k,abs(Y))