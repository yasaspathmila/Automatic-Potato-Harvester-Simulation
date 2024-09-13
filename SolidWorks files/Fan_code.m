%% Potato Harvester Fan System Simulation
%This is a small simulation of our fan system
%The fan speeds are varying with the feed rate 
%this will output the average fan speed and total harvested potato amount


clc;
close all;
clear all;

%% Inputs to the system( We can change these variables according to our requirements)
maxFanSpeed = 1000; % Maximum fan speed (in RPM)
minFanSpeed = 200; % Minimum fan speed (in RPM)
maxFeedRate = 5; % Maximum feed rate (in kg/s)
variationAmplitude = 0.8; % Amplitude of random feed rate variations

% Simulation parameters
% We have done this calculation only for a minute for the  simplicity  

simulationTime = 60; % seconds
timeStep = 0.1; % Sampling time (in seconds)

%% Creating arrays to store calculated data 

time = 0:timeStep:simulationTime;
fanSpeeds = zeros(size(time));
feedRateVariations = variationAmplitude * randn(size(time)); % Random feed rate variations
harvestedPotatoes = zeros(size(time));
feedRate = zeros(size(time));

%% Calculating the stroing the intermediate values

for i = 1:length(time)
    % Simulate varying feed rate
    % feedRate =  time varying feed rate
    % Here we have used a sinusoidal wave as the feed rate but we can use any other waveform 
    feedRate(i) = maxFeedRate * abs((sin(2 * pi * 0.1 * time(i))) + abs(feedRateVariations(i)));
    
    % Adjust fan speed based on feed rate 
    % fanSpeed = maxFanSpeed * (feed rate/ maximum feedRate )
    %This speed should be vary in between the maximum and minimum fan speeds
    fanSpeed = min(maxFanSpeed, max(minFanSpeed, maxFanSpeed * (feedRate(i) / maxFeedRate)));
    
    % Store the fan speeds 
    fanSpeeds(i) = fanSpeed;
    
    % Calculate harvested potatoes based on feed rate and time
    harvestedPotatoes(i) = feedRate(i) * timeStep;
end

%% Displaying the simulation results

figure;
% Ploting the feed rate variation
subplot(2, 1, 1);
plot(time, feedRate,'m', 'LineWidth', 2);
title('Feed Rate Variation with time');
xlabel('Time (s)');
ylabel('Feed Rate (kg/s)');
grid on;



% Adding a main title to the graph
sgtitle('Variation of Fan Speed with Feed Rate');


% Ploting the harvested potatoes over time
figure;
plot(time, harvestedPotatoes,'r', 'LineWidth', 2);
title('Harvested Potatoes over Time');
xlabel('Time (s)');
ylabel('Harvested Potatoes (kg)');
grid on;

%% Displaying the overall performance

fprintf('Total Potatoes Harvested: %.2f kg\n', sum(harvestedPotatoes));
fprintf('Average Fan Speed: %.2f RPM\n', mean(fanSpeeds));