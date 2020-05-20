function [newLabelledImage] = processZStack(labelledImage,newLabelledImage, zIntermediate,zSlices,zDirection)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

actualCells=regionprops(labelledImage(:,:,zIntermediate),'Centroid');
allCentroidDistance=[];

for indexCell= 1:size(actualCells,1) 
    
    actualCentroid=actualCells(indexCell).Centroid;
    
    for zIndex=(1:zSlices)*zDirection
        
        nextImg=labelledImage(:,:,zIntermediate-zIndex);
        cellsNextZslice=struct2table(regionprops(labelledImage(:,:,zIntermediate-zIndex),'Centroid'));
        centroidIndex = find(min(pdist2(actualCentroid,cellsNextZslice.Centroid,'euclidean')));
        [minCentroidDistance,centroidIndex] = min(pdist2(actualCentroid,cellsNextZslice.Centroid,'euclidean'));
        allCentroidDistance(indexCell,abs(zIndex))= minCentroidDistance;
        
        if indexCell ~= centroidIndex
            nextImg(nextImg==indexCell)=0;
            nextImg(nextImg==centroidIndex)=indexCell;
        end
        actualImg = newLabelledImage(:,:,zIntermediate-zIndex);
        
        %% Check if this location has been labelled and if the label is correct comparing minimun centroid distances.
        if max(actualImg(nextImg==indexCell)) ~= 0
            if allCentroidDistance(max(actualImg(nextImg==indexCell)),abs(zIndex)) < minCentroidDistance
                break
            end
            
        end
        
        actualImg(nextImg==indexCell)=indexCell;
        newLabelledImage(:,:,zIntermediate-zIndex) = actualImg;
        actualCentroid=cellsNextZslice(centroidIndex,:).Centroid;
        
    end
end

end