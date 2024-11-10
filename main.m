% Assuming an indefinite loop. Break condition not specified.
% Open a new file named 'coordinates.csv' for writing
fileID = fopen('A.csv', 'w');

% Check if the file was successfully opened
if fileID == -1
    error('Failed to create the file.');
else
    fprintf('File created successfully.\n');
    fclose(fileID); % Close the file after creating it
end

fileID = fopen('B.csv', 'w');

% Check if the file was successfully opened
if fileID == -1
    error('Failed to create the file.');
else
    fprintf('File created successfully.\n');
    fclose(fileID); % Close the file after creating it
end

fileID = fopen('C.csv', 'w');

% Check if the file was successfully opened
if fileID == -1
    error('Failed to create the file.');
else
    fprintf('File created successfully.\n');
    fclose(fileID); % Close the file after creating it
end


while true
    %% Loads the algorithm settings and the IMU data
    disp('Loads the algorithm settings and the IMU data')
    u=settingA();

    %% Run the zero-velocity detector 
    disp('Runs the zero velocity detector')
    [zupt T]=zero_velocity_detector(u);

    %% Run the Kalman filter
    disp('Runs the filter')
    [x_h cov]=ZUPTaidedINS(u,zupt);

    %% Print the horizontal error and spherical error at the end of the
    %% trajectory
    sprintf('Horizontal error = %0.5g , Spherical error = %0.5g',sqrt(sum((x_h(1:2,end)).^2)), sqrt(sum((x_h(1:3,end)).^2)))

    %% View the result 
    disp('Views the data')
    coordinateA;
    
   %% Loads the algorithm settings and the IMU data
    disp('Loads the algorithm settings and the IMU data')
    u=settingB();

    %% Run the zero-velocity detector 
    disp('Runs the zero velocity detector')
    [zupt T]=zero_velocity_detector(u);

    %% Run the Kalman filter
    disp('Runs the filter')
    [x_h cov]=ZUPTaidedINS(u,zupt);

    %% Print the horizontal error and spherical error at the end of the
    %% trajectory
    sprintf('Horizontal error = %0.5g , Spherical error = %0.5g',sqrt(sum((x_h(1:2,end)).^2)), sqrt(sum((x_h(1:3,end)).^2)))

    %% View the result 
    disp('Views the data')
    coordinateB;

    %% Loads the algorithm settings and the IMU data
    disp('Loads the algorithm settings and the IMU data')
    u=settingC();

    %% Run the zero-velocity detector 
    disp('Runs the zero velocity detector')
    [zupt T]=zero_velocity_detector(u);

    %% Run the Kalman filter
    disp('Runs the filter')
    [x_h cov]=ZUPTaidedINS(u,zupt);

    %% Print the horizontal error and spherical error at the end of the
    %% trajectory
    sprintf('Horizontal error = %0.5g , Spherical error = %0.5g',sqrt(sum((x_h(1:2,end)).^2)), sqrt(sum((x_h(1:3,end)).^2)))

    %% View the result 
    disp('Views the data')
    coordinateC;

    % Pause for 1 second before the next iteration
    %pause(1);
end
