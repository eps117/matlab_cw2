% Ethan Sheerin
% efyes9@nottingham.ac.uk
clear
clc

%--------------------------------------------------------------------------
%Preliminary Task - Arduino and GIT Instillation (10 marks):

a = arduino();        % Establishes connection with arduino and function 'a'
num_blinks = 10;    % Number of blinks the LED will perofrm

for i = 1:num_blinks
    writeDigitalPin(a,'d12',1);     % Turns LED on --> '1' means high level --> 5V supplied
    pause(0.5)                      % Pauses for 0.5s
    writeDigitalPin(a,'d12',0)      % Turns LED on --> '0' means low level --> 0V supplied
    pause(0.5)                      % Pauses for 0.5s
end