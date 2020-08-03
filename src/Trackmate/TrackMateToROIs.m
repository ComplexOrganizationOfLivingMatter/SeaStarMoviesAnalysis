%% Important consider take a look at: https://github.com/fiji/TrackMate/tree/master/scripts
% addpath('D:\Pablo\TrackMate_clones\scripts\');
% 
% tracksXML = importTrackMateTracks('Trackmate\20200114_miniata_rasGFP_H2BRFP_32cellsTohatch_pos4_Tracks.xml');

clear all
close all

spotsStatistics = readtable('..\..\..\20200114_miniata_rasGFP_H2BRFP_32cellsTohatch_pos4\Trackmate\All Spots statistics.csv');

voxelDepth = 1.1501322;
PixelWidth = 0.1863522;


tracksWithNaNs = unique(str2double(spotsStatistics.TRACK_ID)');
tracksWithNaNs(isnan(tracksWithNaNs)) = [];
for numCell = tracksWithNaNs
    selectedCellTrajectory = cellfun(@(x) isequal(x, num2str(numCell)), spotsStatistics.TRACK_ID);

    currentCellTrack = spotsStatistics(selectedCellTrajectory, :);

    currentPoint = currentCellTrack(1, :);
    selectedZ = round(currentPoint.POSITION_Z / voxelDepth);
    for numSpot = 1:size(currentCellTrack, 1)

        currentPoint = currentCellTrack(numSpot, :);
        if currentFrame ~= currentPoint.FRAME
            hold off;
            imshow(imadjust(image4D{selectedZ, currentPoint.FRAME+1}));
            hold on;
        end

        plot(round(currentPoint.POSITION_X/PixelWidth), round(currentPoint.POSITION_Y/PixelWidth), 'rx')


        currentFrame = currentPoint.FRAME;
    end
end