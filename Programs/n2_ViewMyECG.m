clear all;
close all;
clc;

% Load recorded ECG
load('ECG_raw.mat');

% Display basic information
disp('Sampling frequency:');
disp(Fs);

disp('Number of samples:');
disp(length(ecg));

disp('Recording duration (seconds):');
disp(length(ecg)/Fs);

% Plot raw ECG
figure;
plot(t, ecg);
xlabel('Time (seconds)');
ylabel('ADC Value');
title('Raw ECG Signal');
grid on;

figure;
plot(t(1:5*Fs), ecg(1:5*Fs));
xlabel('Time (seconds)');
ylabel('ADC Value');
title('Raw ECG - First 5 Seconds');
grid on;