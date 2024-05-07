clc 
clear
% TASK 2 - Led Temperature Monitoring Device Implementation [25 Marks]:

duration = 600;     % Duration of voltage run time in seconds (10 mins)

num_data_points = duration;                     % Defining the number of data points
voltage_recording = zeros(1, num_data_points);  % Array to store acquired data for voltage

a = arduino();      % Establishing a connection with the arduino
for i = 1:num_data_points                           % Reads the voltage over the duration
    voltage_recording(i) = readVoltage(a, "A0");    % Reads the voltage from the from the A0 channel

    %pause(1)    % 1 second pause between each reading
end

   
TC = 0.1;      % Temperature coefficient of sensor given from the data sheet (10Mv/C)
V_0C = 0.5;     % Zero-degree-voltage given from the data sheet (500mV) 

temperature_calculated = (voltage_recording - V_0C)/TC;  % Calculating temperature values at the different voltage readings using the zero-degree-voltage abd temperature coefficient

% Define threshold temperatures
lower_threshold = 18;
upper_threshold = 24;


% Define Arduino pins for LEDs
green_led = 'D12';
yellow_led = 'D11';
red_led = 'D10';

% Initialize Arduino
%a = arduino(); 

% Turn off all LEDs initially
writeDigitalPin(a, green_led, 0);
writeDigitalPin(a, yellow_led, 0);
writeDigitalPin(a, red_led, 0);

while true
    temperature_calculated = (voltage_recording - V_0C)/TC;
% Check temperature and control LEDs accordingly
if temperature_calculated < lower_threshold
    % Temperature is less than 18 degrees
    writeDigitalPin(a, green_led, 0);
    writeDigitalPin(a, red_led, 0);
    % Making yellow LED blink in 0.5s intervals
    writeDigitalPin(a, yellow_led, 1);
    pause(0.5);
    writeDigitalPin(a, yellow_led, 0);
    pause(0.5);
elseif all(temperature_calculated >= lower_threshold) && all(temperature_calculated <= upper_threshold)
    % Temperature is between 18 and 24 degrees
    writeDigitalPin(a, green_led, 1);
    writeDigitalPin(a,yellow_led, 0);
    writeDigitalPin(a, red_led, 0);
elseif temperature_calculated < upper_threshold
    % Temperature is above 24 degrees
    writeDigitalPin(a, green_led, 0);
    writeDigitalPin(a, yellow_led, 0);
    % Making red LED blink in intervals of 0.25 seconds 
    writeDigitalPin(a, red_led, 1);
    pause(0.25);
    writeDigitalPin(a, red_led, 0);
    pause(0.25);
end
end 
