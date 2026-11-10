% CHEMOTAXIS SIMULATION 
% One MATLAB script     
% Concentration: z = 1 / (1 + 0.001*(x^2 + y^2))
% Tumbling probability: P_tumble = 1 - z
%
% This model makes tumbling probability depend on position.
% It does not add a directional bias toward the concentration source.

clear;
clc;
close all;

%% 1. Simulation settings
numberOfBacteria = 20;
numberOfSteps = 1000;
stepLength = 1;
rng(42); % Repeatable random sequence

%% 2. Chemical concentration field
gridLimit = 500;
numberOfGridPoints = 101;

xValues = linspace(-gridLimit, gridLimit, numberOfGridPoints);
yValues = linspace(-gridLimit, gridLimit, numberOfGridPoints);
[Xgrid, Ygrid] = meshgrid(xValues, yValues);

Z = 1 ./ (1 + 0.001 .* (Xgrid.^2 + Ygrid.^2));

%% 3. Set up bacterial positions
% All bacteria start at (0, 0).
xPosition = zeros(numberOfBacteria, numberOfSteps + 1);
yPosition = zeros(numberOfBacteria, numberOfSteps + 1);

% Each bacterium starts in a random direction.
direction = 2 * pi * rand(numberOfBacteria, 1);

% Store the tumbling probability at each time step.
tumblingProbability = zeros(numberOfBacteria, numberOfSteps);

%% 4. Simulate movement
for step = 1:numberOfSteps
    for bacterium = 1:numberOfBacteria

        currentX = xPosition(bacterium, step);
        currentY = yPosition(bacterium, step);

        % Calculate concentration and tumbling probability here.
        localConcentration = 1 / (1 + 0.001 * ...
            (currentX^2 + currentY^2));
        localTumblingProbability = 1 - localConcentration;

        tumblingProbability(bacterium, step) = ...
            localTumblingProbability;

        % A tumble means choosing a new random direction.
        if rand < localTumblingProbability
            direction(bacterium) = 2 * pi * rand;
        end

        % Move one step in the current direction.
        xPosition(bacterium, step + 1) = currentX + ...
            stepLength * cos(direction(bacterium));
        yPosition(bacterium, step + 1) = currentY + ...
            stepLength * sin(direction(bacterium));
    end
end

%% 5. Create folder for saved figures
resultsFolder = fullfile(pwd, 'Results');
if ~exist(resultsFolder, 'dir')
    mkdir(resultsFolder);
end

%% 6. Figure 1: Chemical concentration field
figure(1);
contourf(Xgrid, Ygrid, Z, 20, 'LineColor', 'none');
colorbar;
xlabel('x position');
ylabel('y position');
title('Chemical Concentration Field');
axis equal;
saveas(gcf, fullfile(resultsFolder, 'Figure1_Concentration.png'));

%% 7. Figure 2: Bacterial trajectories
figure(2);
plot(xPosition', yPosition');
xlabel('x position');
ylabel('y position');
title('Bacterial Trajectories');
axis equal;
grid on;
saveas(gcf, fullfile(resultsFolder, 'Figure2_Trajectories.png'));

%% 8. Figure 3: Horizontal position versus time
figure(3);
plot(0:numberOfSteps, xPosition');
xlabel('Time step');
ylabel('Horizontal position (x)');
title('Horizontal Position vs. Time');
grid on;
saveas(gcf, fullfile(resultsFolder, 'Figure3_X_Position.png'));

%% 9. Figure 4: Vertical position versus time
figure(4);
plot(0:numberOfSteps, yPosition');
xlabel('Time step');
ylabel('Vertical position (y)');
title('Vertical Position vs. Time');
grid on;
saveas(gcf, fullfile(resultsFolder, 'Figure4_Y_Position.png'));

%% 10. Figure 5: Average tumbling probability versus time
averageTumblingProbability = mean(tumblingProbability, 1);
figure(5);
plot(1:numberOfSteps, averageTumblingProbability, 'LineWidth', 1.5);
xlabel('Time step');
ylabel('Average tumbling probability');
title('Average Tumbling Probability vs. Time');
ylim([0 1]);
grid on;
saveas(gcf, fullfile(resultsFolder, 'Figure5_Tumbling_Probability.png'));

%% 11. Finish
disp('Simulation finished successfully.');
disp('The five figures were saved in the Results folder:');
disp(resultsFolder);
