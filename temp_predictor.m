clear 
clc

a = arduino();      % Establishing a connection with the arduino

i = 0;  % Starting indefinite loop (while truw)
while true  
    i = i + 1;  % loop increasing in increments of 1
    
    voltage_recording(i) = readVoltage(a, "A0");    % Reads voltage (from the A0 channel)
    
    % Calculate temperature for each voltage reading
    TC = 0.1;      % Temperature coefficient of sensor given from the data sheet (10mV/C)
    V_0C = 0.5;     % Zero-degree-voltage given from the data sheet (500mV) 
    temperature_calculated(i) = (voltage_recording(i) - V_0C) / TC;
    pause(1)
    
    fprintf('\n%s\n', temperature_calculated)    % Printing to the command screen
end
