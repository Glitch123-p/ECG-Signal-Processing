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
s.InputBufferSize = 10000;

fopen(s);

% ECG settings
Fs = 500;
windowTime = 4;
N = Fs * windowTime;

% Fixed-size ECG buffer
ecg = zeros(1, N);

% Fixed-size time vector
t = (0:N-1)/Fs;

% Create figure
figure('Name','Live ECG');

h = plot(t, ecg);

xlabel('Time (seconds)');
ylabel('ADC Value');
title('Live ECG');
grid on;

axis([0 windowTime 0 1023]);

% Live loop
while ishandle(gcf)

    if s.BytesAvailable > 0

        % Read ONE value
        data = fscanf(s, '%d');

        % Make sure we received exactly one value
        if length(data) == 1

            % Shift buffer
            ecg(1:N-1) = ecg(2:N);

            % Insert new sample
            ecg(N) = data;

            % Update only Y data
            set(h, 'YData', ecg);

            drawnow;
        end
    end
end

% Close serial
fclose(s);
delete(s);
clear s;