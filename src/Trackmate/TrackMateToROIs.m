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
    
    %Info per cell: ID_Track ID_Cell Father Frame Centroid_X Centroid_Y Centroid_Z Centroid_XCorrected Centroid_YCorrected Centroid_ZCorrected
    newCells = [numCell newIdCell -1 allFramesAtCurrentCell(1)+1 currentCellTrack.POSITION_X(1) currentCellTrack.POSITION_Y(1) currentCellTrack.POSITION_Z(1) ...
        round(currentCellTrack.POSITION_X(1)/PixelWidth) round(currentCellTrack.POSITION_Y(1)/PixelWidth) round(currentCellTrack.POSITION_Z(1)/voxelDepth)];
    for numFrame = 2:length(allFramesAtCurrentCell)
        newCellsPastFrame = newCells(newCells(:, 4) == numFrame - 1, :);
        
        currentCellTrackPerFrame = currentCellTrack(currentCellTrack.FRAME == allFramesAtCurrentCell(numFrame), :);
        newDivisions = size(currentCellTrackPerFrame, 1) - numberOfCellsPerFrame;
        
        newCellsCurrentFrame = [];
        for numSpot = 1:size(currentCellTrackPerFrame, 1)
            currentPoint = currentCellTrackPerFrame(numSpot, :);
            
            %Look for closest cell
            [~, closestCell] = pdist2(newCellsPastFrame(:, 5:7), [currentPoint.POSITION_X currentPoint.POSITION_Y currentPoint.POSITION_Z], 'euclidean', 'Smallest', 1);
            newCellsCurrentFrame(end+1, :) = [newCellsPastFrame(closestCell, 1:3) numFrame currentPoint.POSITION_X(1) currentPoint.POSITION_Y(1) currentPoint.POSITION_Z(1) ...
                round(currentPoint.POSITION_X(1)/PixelWidth) round(currentPoint.POSITION_Y(1)/PixelWidth) round(currentPoint.POSITION_Z(1)/voxelDepth)];
        end
        
        uniqueIds = unique(newCellsCurrentFrame(:, 2));
        [numberOfOccurrences, matching] = histc(newCellsCurrentFrame(:, 2), uniqueIds);
        idOcurrences = uniqueIds(numberOfOccurrences>1);
        
        %Was there a division in the previous frame? If so, there was a
        %division
        if newDivisions > 0
            if any(numberOfOccurrences > 2)
                disp('Crazy things just happenned. Please consider split your 4D image');
                break
            end
            for changeId = idOcurrences'
                daughterCells = find(newCellsCurrentFrame(:, 2) == changeId);
                newIdCell = newIdCell + 1;
                fatherCell = newCellsCurrentFrame(daughterCells(1), 2);
                newCellsCurrentFrame(daughterCells(1), 2:3) = [newIdCell fatherCell];

                newIdCell = newIdCell + 1;
                newCellsCurrentFrame(daughterCells(2), 2:3) = [newIdCell fatherCell];
            end
        elseif length(uniqueIds) < size(newCellsCurrentFrame, 1) %% Missing cell
            missingCells = setdiff(newCellsPastFrame(:, 2), uniqueIds);
            if length(missingCells) > 1
                disp('More than one missing cell');
                break
            end
            for changeId = idOcurrences'
                [distances, closestId] = pdist2(newCellsCurrentFrame(newCellsCurrentFrame(:, 2) == changeId, 7), newCellsPastFrame(newCellsPastFrame(:, 2) == changeId, 7), 'euclidean', 'Smallest', 1);
                cellsToChange = find(newCellsCurrentFrame(:, 2) == changeId);
                cellsToChange(closestId) = [];
                newCellsCurrentFrame(cellsToChange, 2) = missingCells(1);
            end
            newCellsCurrentFrame;
        end
        
        newCells = [newCells; newCellsCurrentFrame];
        
        numberOfCellsPerFrame = size(currentCellTrackPerFrame, 1);
    end
    newIdCell = newIdCell + 1;
    cellsInfo(numCell+1) = {newCells};
end