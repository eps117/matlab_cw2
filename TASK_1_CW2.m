clear
clc

% TASK ONE - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE[20 Marks]

duration = 600;     % Duration of voltage run time in seconds (10 mins)

num_data_points = duration;                     % Defining the number of data points
voltage_recording = zeros(1, num_data_points);  % Array to store acquired data for voltage

a = arduino();      % Establishing a connection with the arduino
for i = 1:num_data_points                           % Reads the voltage over the duration
    voltage_recording(i) = readVoltage(a, "A0");    % Reads the voltage from the from the A0 channel

    %pause(1)    % 1 second pause between each reading
end

clear a;
   
TC = 0.1;      % Temperature coefficient of sensor given from the data sheet (10Mv/C)
V_0C = 0.5;     % Zero-degree-voltage given from the data sheet (500mV) 

temperature_calculated = (voltage_recording - V_0C)/TC;  % Calculating temperature values at the different voltage readings using the zero-degree-voltage abd temperature coefficient

% Calculating the minimum, maximum and average temperature values from the
% temperature calculations
min_temp = min(temperature_calculated);
max_temp = max(temperature_calculated);
avg_temp = mean(temperature_calculated); 

% Plotting the recorded values for temperature against time:
time = (1:1:num_data_points);   % Defining time - goes in increments of 1 so has the same amount of points as the calculated temperatur

plot(time, temperature_calculated); % Plot of the graph
xlabel('Time (s)');                 % X axis labelled
ylabel('Temperature (C)');          % Y axis labelled
title('Temperature vs Time');       % Title of the graph
grid on;                            % Turns on the grid 


intro = sprintf('Data logging initiated - 5/3/2024\nLocation - Nottingham');    % Assigning a variable to the title
outro = sprintf('\n\nData logging terminated');                                 % Assigning a variable to the bottom text
maximum = sprintf('\n\nMax temp \t\t%.2f C',max_temp);                          % Assigning a variable for max temp
minimum = sprintf('\nMin temp \t\t%.2f C', min_temp);                           % Assigning a variable for min temp
avgerage = sprintf('\nAverage temp \t%.2f C', avg_temp);                        % Assigning a variable for avg temp

% Finding calculated temp at 0,1,2,3,4,5,6,7,8,9 and 10 minutes:
temp_0 = temperature_calculated(1);     
temp_1 = temperature_calculated(61);
temp_2 = temperature_calculated(121);
temp_3 = temperature_calculated(181);
temp_4 = temperature_calculated(241);
temp_5 = temperature_calculated(301);
temp_6 = temperature_calculated(361);
temp_7 = temperature_calculated(421);
temp_8 = temperature_calculated(481);
temp_9 = temperature_calculated(541);
temp_10 = temperature_calculated(600);

% Formatting each line of text into a string. each string contains the
% minute and temperature for that minute:
formatted_string0 = sprintf('\n\nMinute\t\t\t0\nTemperature\t\t%.2f C', temp_0);
formatted_string1 = sprintf('\n\nMinute\t\t\t1\nTemperature\t\t%.2f C', temp_1);
formatted_string2 = sprintf('\n\nMinute\t\t\t2\nTemperature\t\t%.2f C', temp_2);
formatted_string3 = sprintf('\n\nMinute\t\t\t3\nTemperature\t\t%.2f C', temp_3);
formatted_string4 = sprintf('\n\nMinute\t\t\t4\nTemperature\t\t%.2f C', temp_4);
formatted_string5 = sprintf('\n\nMinute\t\t\t5\nTemperature\t\t%.2f C', temp_5);
formatted_string6 = sprintf('\n\nMinute\t\t\t6\nTemperature\t\t%.2f C', temp_6);
formatted_string7 = sprintf('\n\nMinute\t\t\t7\nTemperature\t\t%.2f C', temp_7);
formatted_string8 = sprintf('\n\nMinute\t\t\t8\nTemperature\t\t%.2f C', temp_8);
formatted_string9 = sprintf('\n\nMinute\t\t\t9\nTemperature\t\t%.2f C', temp_9);
formatted_string10 = sprintf('\n\nMinute\t\t\t10\nTemperature\t\t%.2f C', temp_10);

% Assigning a variable to the data print on the screen to make it easier to
% write to another file:
screen_output = ([intro, formatted_string0, formatted_string1, formatted_string2, formatted_string3, formatted_string4, formatted_string5, formatted_string6, formatted_string7, formatted_string8, formatted_string9, formatted_string10, maximum, minimum, avgerage, outro]); 

% Opening the file (cabin_temperature.txt):
file_id = fopen('cabin_temperature.txt','w');
% using fprintf to write to the file:
fprintf(file_id,'%s',screen_output);
% Closing the file;
fclose(file_id);
