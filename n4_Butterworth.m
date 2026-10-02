clear all;
close all;
clc;

load('ECG_raw.mat');

% 4th-order Butterworth band-pass filter
% Passband: 0.5 Hz to 40 Hz

[b, a] = butter(4, [0.5 40]/(Fs/2), 'bandpass');

% Zero-phase filtering for offline processing
ecg_filtered = filtfilt(b, a, ecg);

% Plot raw and filtered ECG
figure;

subplot(2,1,1);
plot(t, ecg);
xlabel('Time (seconds)');
ylabel('ADC');
title('Raw ECG');
grid on;

subplot(2,1,2);
plot(t, ecg_filtered);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Filtered ECG - 0.5 to 40 Hz');
grid on;

% First 5 seconds
figure;

subplot(2,1,1);
plot(t(1:5*Fs), ecg(1:5*Fs));
xlabel('Time (seconds)');
ylabel('ADC');
title('Raw ECG - First 5 Seconds');
grid on;

subplot(2,1,2);
plot(t(1:5*Fs), ecg_filtered(1:5*Fs));
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Filtered ECG - First 5 Seconds');
grid on;

% Save filtered signal
save('ECG_filtered.mat', 'ecg_filtered', 't', 'Fs');

disp('Filtered ECG saved as ECG_filtered.mat');