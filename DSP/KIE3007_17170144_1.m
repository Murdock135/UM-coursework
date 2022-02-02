clear, clc, close all

[x, fs] = audioread('17170144_noisy.wav');	% load an audio file

x = x(:, 1);            % get the first channel
N = length(x);          % signal length
t = (0:N-1)/fs;         % time vector
Ts=1/fs;                % sampling time

xfft = fft(x);          % DFT coefficient
k = (0:(N-1)/2);        
f = fs*k/N;             % formula for frequency bin
y = (2*abs(xfft))/N;    % Amplitude Spectrum k>0
y(1) = y(1)/2;          % Amplitude Spectrum k=0

% Filter the signal
fc = 9510;              % Cutoff frequency

% Design a Butterworth filter.
[b, a] = butter(6,fc/(fs/2));

% Apply the Butterworth filter.
filteredSignal = filter(b, a, x);
audiowrite('17170144_filtered.wav',filteredSignal,fs)%save the filtered audio to computer

fsfft = fft(filteredSignal);    % DFT coefficient
yf = (2*abs(fsfft))/N;          % Amplitude Spectrum k>0
yf(1) = yf(1)/2;                % Amplitude Spectrum k=0

% time-frequency analysis
winlen = round(N/1000);
win = blackman(winlen, 'periodic');
hop = round(winlen/4);
nfft = round(2*winlen);
[~, F, T, STPSD] = spectrogram(filteredSignal, win, winlen-hop, nfft, fs, 'psd');
STPSD = 10*log10(STPSD);

%% Plot all waveforms

figure(1)
plot(t, x)
xlim([0 max(t)])
ylim([-1.1*max(abs(x)) 1.1*max(abs(x))])
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Amplitude, V')
title('Oscillogram of the noise signal') 

figure(2)
% Single Sided Amplitude Spectrum
plot(f,y(1:N/2));
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 12)
xlabel('Frequency(Hz)')
ylabel('Amplitude |A(k)|')
title('Single Sided Amplitude Spectrum (input)')

% Frequency response of digital filter
figure(3)
freqz(b,a)
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
title('Frequency response of the digital filter')

% Impulse Response
figure(4)
impulse(b,a);
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
title('Impulse Response')

% Zero-Pole Plot
figure(5)
zplane(b,a);
title('Pole-Zero Plot of Filter');
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)

figure(6)
plot(t, filteredSignal)
xlim([0 max(t)])
ylim([-1.1*max(abs(filteredSignal)) 1.1*max(abs(filteredSignal))])
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Amplitude, V')
title('Oscillogram of the filtered signal') 

figure(7)
% Single Sided Amplitude Spectrum
plot(f,yf(1:N/2));
grid minor
set(gca, 'FontName', 'Times New Roman', 'FontSize', 12)
xlabel('Frequency(Hz)')
ylabel('Amplitude |A(k)|')
title('Single Sided Amplitude Spectrum (output)')

figure(8)
surf(T, F, STPSD)
shading interp
axis tight
box on
view(0, 90)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Frequency, Hz')
title('Spectrogram of the filtered signal')

[~, cmax] = caxis;
caxis([max(-120, cmax-90), cmax])

hClbr = colorbar;
set(hClbr, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(hClbr, 'Magnitude, dBV^2/Hz')
