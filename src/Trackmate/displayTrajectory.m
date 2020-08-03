%% Read image sequence of 4D image
imageSequenceFiles = dir('Trackmate/imageSequence/*.tif');
image4D = {};
for numFile = 1:length(imageSequenceFiles)
    currentFolder = imageSequenceFiles(numFile).folder;
    currentName = imageSequenceFiles(numFile).name;
    
    currentNameSplitted = strsplit(currentName, '_');
    timePointString = currentNameSplitted{end-1};
    timePoint = str2double(timePointString(2:end));
    
    zPointString = currentNameSplitted{end};
    zPoint = str2double(zPointString(2:5));
    
    image4D(zPoint, timePoint) = {imread(fullfile(currentFolder, currentName))};
end

%% Read spots data 
spotsStatistics = readtable('Trackmate\All Spots statistics.csv');

selectedCellTrajectory = cellfun(@(x) isequal(x, '3'), spotsStatistics.TRACK_ID);

oneSpot = spotsStatistics(selectedCellTrajectory, :);

voxelDepth = 1.1501322;
PixelWidth = 0.1863522;
figure;
currentFrame = -1;
currentPoint = oneSpot(1, :);
selectedZ = round(currentPoint.POSITION_Z / voxelDepth);
for numSpot = 1:size(oneSpot, 1)
    
    currentPoint = oneSpot(numSpot, :);
    if currentFrame ~= currentPoint.FRAME
        hold off;
        imshow(imadjust(image4D{selectedZ, currentPoint.FRAME+1}));
        hold on;
    end
    
    plot(round(currentPoint.POSITION_X/PixelWidth), round(currentPoint.POSITION_Y/PixelWidth), 'rx')
    
    currentFrame = currentPoint.FRAME;
end