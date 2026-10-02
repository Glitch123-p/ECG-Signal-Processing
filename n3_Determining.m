clear all;
close all;
clc;

load('ECG_raw.mat');

% Take first 5 seconds
x = ecg(1:5*Fs);
tt = t(1:5*Fs);

% Remove DC component for analysis
x_ac = x - mean(x);

% RMS of signal
rms_value = sqrt(mean(x_ac.^2));

fprintf('Mean value = %.2f\n', mean(x));
fprintf('RMS value  = %.2f\n', rms_value);

% FFT
N = length(x_ac);

Y = fft(x_ac);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(N/2))/N;

% Find dominant frequencies below 100 Hz
range = find(f <= 100);

[magnitude, index] = max(P1(range));

fprintf('Dominant frequency below 100 Hz = %.2f Hz\n', f(range(index)));
fprintf('Magnitude at dominant frequency = %.2f\n', magnitude);

% Plot spectrum
figure;
plot(f, P1);
xlim([0 100]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('ECG Frequency Spectrum');
grid on;