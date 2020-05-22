function [basalLayer,apicalLayer] = getApicalAndBasalFrom3DImage(labelledImage)
%GETBASALFROM3DIMAGE Summary of this function goes here
%   Detailed explanation goes here
basalLayer=zeros(size(labelledImage));
apicalLayer=zeros(size(labelledImage));

for nCells=1:max(max(max(labelledImage)))
    cellsZIndex=arrayfun(@(x) find(labelledImage(x,:,:)==nCells),1:size(labelledImage,3), 'UniformOutput',false);
    minZIndex=find(cellfun(@(x,y) ~isempty(x), cellsZIndex)==1);
    maxZIndex=find(cellfun(@(x,y) ~isempty(x), cellsZIndex)==1,1,'last');
    
    actualBasalLayer=basalLayer(:,:,minZIndex);
    actualApicalLayer=apicalLayer(:,:,maxZIndex);
    actualBasalLayer(labelledImage(:,:,minZIndex)==nCells)=nCells;
    actualApicalLayer(labelledImage(:,:,maxZIndex)==nCells)=nCells;
    
    basalLayer(:,:,minZIndex)=actualBasalLayer;
    apicalLayer(:,:,maxZIndex)=actualApicalLayer;
end

end

