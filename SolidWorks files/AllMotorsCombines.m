%% Potato Harvester Fan System, Brush system and sieving system Simulation
%This is a small simulation of our fan system
%The fan speeds are varying with the feed rate 
%this will output the average fan speed, brush speed, sieving speed and total harvested potato amount


clc;
close all;
clear all;

%% Inputs to the system( We can change these variables according to our requirements)
maxFanSpeed = 750; % Maximum fan speed (in RPM)
minFanSpeed = 250; % Minimum fan speed (in RPM)

maxBrushSpeed = 500; % Maximum brush speed (in RPM)
minBrushSpeed = 200; % Minimum brush speed (in RPM)

maxSievingSpeed = 400; % Maximum sieving speed (in RPM)
minSievingSpeed = 100; % Minimum sieving speed (in RPM)

maxFeedRate = 5; % Maximum feed rate (in kg/s)
variationAmplitude = 0.8; % Amplitude of random feed rate variations

% Simulation parameters
% We have done this calculation only for a minute for the  simplicity  

simulationTime = 60; % seconds
timeStep = 0.1; % Sampling time (in seconds)

%% Creating arrays to store calculated data 

time = 0:timeStep:simulationTime;

fanSpeeds = zeros(size(time));
brushSpeeds = zeros(size(time));
sievingSpeeds = zeros(size(time));

feedRateVariations = variationAmplitude * randn(size(time)); % Random feed rate variations
harvestedPotatoes = zeros(size(time));
feedRate = zeros(size(time));

%% Calculating the stroing the intermediate values

for i = 1:length(time)
    % Simulate varying feed rate 
    % feedRate =  time varying feed rate 
    % Here we have used a sinusoidal wave as the feed rate but we can use any other waveform 
    feedRate(i) = maxFeedRate * abs((sin(2 * pi * 0.1 * time(i))) + abs(feedRateVariations(i)));
    
    % Adjust fan speed based on feed rate with added noise
    % fanSpeed = maxFanSpeed * (feed rate/ maximum feedRate )
    %This speed should be vary in between the maximum and minimum fan speeds
    fanSpeed = min(maxFanSpeed, max(minFanSpeed, maxFanSpeed * (feedRate(i) / maxFeedRate)));
    
    % Store the fan speeds 
    fanSpeeds(i) = fanSpeed;

    % Adjust brush speed based on feed rate 
    % brushSpeed = maxBrushSpeed * (feed rate/ maximum feedRate ) 
    %This speed should be vary in between the maximum and minimum brush speeds
    brushSpeed = min(maxBrushSpeed, max(minBrushSpeed, maxBrushSpeed * (feedRate(i) / maxFeedRate)));
    
    % Store the fan speeds 
    brushSpeeds(i) = brushSpeed;

    % Adjust sieving speed based on feed rate 
    % sievingSpeed = maxSievingSpeed * (feed rate/ maximum feedRate )
    %This speed should be vary in between the maximum and minimum sieving speeds
    sievingSpeed = min(maxSievingSpeed, max(minSievingSpeed, maxSievingSpeed * (feedRate(i) / maxFeedRate)));
    
    % Store the fan speeds 
    sievingSpeeds(i) = sievingSpeed;
    
    % Calculate harvested potatoes based on feed rate and time
    harvestedPotatoes(i) = feedRate(i) * timeStep;
end

%% Displaying the simulation results

figure;
% Ploting the feed rate variation
subplot(4, 1, 1);
plot(time, feedRate,'m', 'LineWidth', 1);
title('Feed Rate Variation with time');
xlabel('Time (s)');
ylabel('Feed Rate (kg/s)');
grid on;

% Ploting the fan speed variation with given noise
subplot(4, 1, 2);
plot(time, fanSpeeds, 'LineWidth', 1);
title('Fan Speed Variation with time');
xlabel('Time (s)');
ylabel('Fan Speed (RPM)');
grid on;

% Ploting the fan speed variation with given noise
subplot(4, 1, 3);
plot(time, brushSpeeds, 'LineWidth', 1);
title('Brush Speed Variation with time');
xlabel('Time (s)');
ylabel('Brush Speed (RPM)');
grid on;

% Ploting the fan speed variation with given noise
subplot(4, 1, 4);
plot(time, sievingSpeeds, 'LineWidth', 1);
title('Sieving Speed Variation with time');
xlabel('Time (s)');
ylabel('Sieving Speed (RPM)');
grid on;

% Adding a main title to the graph
sgtitle('Variation of Fan Speed, brush speed and sieving speed with Feed Rate');


% % Ploting the noise amplitude
% figure;
% plot(time, noiseAmplitude * randn(size(time)),'g', 'LineWidth', 2);
% title('Noise Amplitude');
% xlabel('Time (s)');
% ylabel('Noise Amplitude');
% grid on;

% Ploting the harvested potatoes over time
figure;
plot(time, harvestedPotatoes,'r', 'LineWidth', 1);
title('Harvested Potatoes over Time');
xlabel('Time (s)');
ylabel('Harvested Potatoes (kg)');
grid on;

%% Displaying the overall performance

fprintf('Total Potatoes Harvested: %.2f kg\n', sum(harvestedPotatoes));
fprintf('Average Fan Speed: %.2f RPM\n', mean(fanSpeeds));
fprintf('Average Brush Speed: %.2f RPM\n', mean(brushSpeeds));
fprintf('Average Sieving Speed: %.2f RPM\n', mean(sievingSpeeds));