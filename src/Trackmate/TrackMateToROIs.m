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

cellsInfo = {};
newIdCell = 1;
numberOfCellsPerFrame = 1;
for numCell = tracksWithNaNs
    selectedCellTrajectory = cellfun(@(x) isequal(x, num2str(numCell)), spotsStatistics.TRACK_ID);
    
    currentCellTrack = spotsStatistics(selectedCellTrajectory, :);
    
    %Unique frames
    allFramesAtCurrentCell = unique(currentCellTrack.FRAME)';
    
    %Info per cell: ID_Track ID_Cell ID_Daughter_1 ID_Daughter_2 Frame Centroid_X Centroid_Y Centroid_Z Centroid_XCorrected Centroid_YCorrected Centroid_ZCorrected
    newCell = [numCell newIdCell -1 -1 allFramesAtCurrentCell(1)+1 currentCellTrack.POSITION_X(1) currentCellTrack.POSITION_Y(1) currentCellTrack.POSITION_Z(1) ...
        round(currentCellTrack.POSITION_X(1)/PixelWidth) round(currentCellTrack.POSITION_Y(1)/PixelWidth) round(currentCellTrack.POSITION_Z(1)/voxelDepth)];
    for numFrame = 2:length(allFramesAtCurrentCell)
        newCellsPastFrame = newCell(newCell(:, 5) == numFrame - 1, :);
        %Was there a division in the previous frame? If so, there was a
        %division
        if length(unique(newCellsPastFrame(:, 2))) > size(newCellsPastFrame, 1)
            [a,b] = histc(x,unique(x));
            y = a(b);
            newIdCell = newIdCell + 1;
            
        end
        
        currentCellTrackPerFrame = currentCellTrack(currentCellTrack.FRAME == allFramesAtCurrentCell(numFrame), :);
        newDivisions = size(currentCellTrackPerFrame, 1) - numberOfCellsPerFrame;
        
        
        for numSpot = 1:size(currentCellTrackPerFrame, 1)
            currentPoint = currentCellTrackPerFrame(numSpot, :);
            
            %Look for closest cell
            [~, closestCell] = pdist2([currentPoint.POSITION_X currentPoint.POSITION_Y currentPoint.POSITION_Z], newCellsPastFrame(:, 6:8), 'euclidean', 'Smallest', 1);
            newCell(end+1, :) = [newCellsPastFrame(closestCell, 1:4) numFrame currentPoint.POSITION_X(1) currentPoint.POSITION_Y(1) currentPoint.POSITION_Z(1) ...
                round(currentPoint.POSITION_X(1)/PixelWidth) round(currentPoint.POSITION_Y(1)/PixelWidth) round(currentPoint.POSITION_Z(1)/voxelDepth)];
        end
        
        numberOfCellsPerFrame = size(currentCellTrackPerFrame, 1);
    end
end