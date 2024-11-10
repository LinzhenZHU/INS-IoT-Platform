% Initialize simulation data and other variables (assuming 'cov' and 'x_h' are defined)
global simdata;
simdata.Ts = 0.1; % Example sampling time, adjust as necessary

% Close all windows
close all;

% Generate a vector with the time scale
N = length(cov); % Assuming 'cov' is defined earlier in your script
t = 0:simdata.Ts:(N-1)*simdata.Ts;

% Initialize matrix to store the coordinates
coordinates = zeros(N, 3);
scaleset = 5;
% Populate the coordinates matrix with x, y, z values
for i = 1:N
    coordinates(i, :) = [scaleset*x_h(2,i), scaleset*x_h(1,i)-28, scaleset*x_h(3,i)]; % Assuming 'x_h' is defined
end

% Print all coordinates that make up the trajectory
for i = 1:N
    fprintf('Coordinate %d: x = %f, y = %f, z = %f\n', i, coordinates(i, 1), coordinates(i, 2), coordinates(i, 3));
end

% Write the new coordinates to a CSV file incrementally
csvFileName = 'C.csv';
write_incremental_coordinates(csvFileName, coordinates);

% Define the function to write incremental coordinates to a CSV file
function write_incremental_coordinates(fileName, matrixData)
    % Validate input data
    if isempty(matrixData)
        warning('No data provided to write.');
        return;
    end
    
    % Check if the file is accessible (not locked by another process)
    [fid, errmsg] = fopen(fileName, 'a');
    if fid == -1
        warning('Failed to open file: %s', errmsg);
        return;
    else
        fclose(fid); % Close the file as we just wanted to check accessibility
    end

    % Check if the file exists and is not just empty
    if isfile(fileName) && dir(fileName).bytes > 0
        % Attempt to read existing data to see if the file is truly empty or just appears so
        try
            fileData = readmatrix(fileName);
            existingCount = size(fileData, 1);
        catch
            % If reading fails, the file might be corrupted or in an unexpected format
            warning('Existing file could not be read properly, it may be corrupted or in an unsupported format.');
            return;
        end
        
        % Determine new data based on what's already written
        newCount = size(matrixData, 1);
        if newCount > existingCount
            % Only append truly new data
            newCoordinates = matrixData(existingCount + 1:end, :);
            dlmwrite(fileName, newCoordinates, '-append', 'delimiter', ',', 'precision', 9);
        end
    else
        % File doesn't exist or is empty, write new data with headers
        headers = {'x', 'y', 'z'};
        % Convert matrixData to cell for compatibility with writecell
        cellData = num2cell(matrixData);
        % Prepend headers
        cellData = [headers; cellData];
        % Write to file with headers
        writecell(cellData, fileName);
    end
end
