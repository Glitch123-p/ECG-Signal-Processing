clear all;
close all;
clc;

% Remove old serial connections
old = instrfind;

if ~isempty(old)
    fclose(old);
    delete(old);
end

% Serial settings
port = 'COM6';
baudrate = 115200;

s = serial(port, 'BaudRate', baudrate);
s.InputBufferSize = 20000;

fopen(s);

% Recording settings
Fs = 500;
duration = 10;          % seconds
N = Fs * duration;

ecg = zeros(N,1);

disp('Starting ECG recording...');
disp('Keep still during recording.');

% Flush old data
flushinput(s);

% Record
for k = 1:N

    data = fscanf(s, '%d');

    if ~isempty(data)
        ecg(k) = data(1);
    end

end

% Close serial connection
fclose(s);
delete(s);
clear s;

disp('Recording complete.');

% Time vector
t = (0:N-1)'/Fs;

% Plot recorded ECG
figure;
plot(t, ecg);
xlabel('Time (seconds)');
ylabel('ADC Value');
title('Raw ECG Signal');
grid on;

% Save data
save('ECG_raw.mat', 'ecg', 't', 'Fs');

disp('Saved as ECG_raw.mat');