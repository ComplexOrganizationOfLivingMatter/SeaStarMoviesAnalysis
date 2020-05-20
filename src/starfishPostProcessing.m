function starfishPostProcessing(outputDir,fileName)
%PIPELINE Summary of this function goes here
%   Detailed explanation goes here

mkdir(fullfile(outputDir, 'Results'));

%% Set Z scale and Pixel width
if exist(fullfile(outputDir, 'Results', 'zScaleOfTissue.mat'), 'file') == 0
    zScale = inputdlg('Insert z-scale of Tissue');
    zScale = str2double(zScale{1});
    
    save(fullfile(outputDir, 'Results', 'zScaleOfTissue.mat'), 'zScale');
else
    load(fullfile(outputDir, 'Results', 'zScaleOfTissue.mat'));
end

if exist(fullfile(outputDir, 'Results', 'pixelScaleOfTissue.mat'), 'file') == 0
    pixelScale = inputdlg('Insert pixel width of Tissue');
    pixelScale = str2double(pixelScale{1});
    
    save(fullfile(outputDir, 'Results', 'pixelScaleOfTissue.mat'), 'pixelScale');
else
    load(fullfile(outputDir, 'Results', 'pixelScaleOfTissue.mat'));
end

%% Load the segmented image sequence.
segmentedImageStack = dir(fullfile(outputDir, 'SegmentedImageSequence', '*.tif'));
NoValidFiles = startsWith({segmentedImageStack.name},'._','IgnoreCase',true);
segmentedImageStack=segmentedImageStack(~NoValidFiles);
imgSize =  size(imread(fullfile(segmentedImageStack(1).folder, segmentedImageStack(1).name)));
labelledImage = zeros(imgSize(1),imgSize(2), size(segmentedImageStack, 1));

nZWithCells=[];
for numZ = 1:size(segmentedImageStack, 1)
    imgZ = imread(fullfile(segmentedImageStack(numZ).folder, segmentedImageStack(numZ).name));
    
    [y, x] = find(imgZ == 0);
    ry=round(y);
    rx=round(x);
    
    rx(rx<1)=1;
    ry(ry<1)=1;
    
    if isempty(x) == 0
        segmentedImageIndices = sub2ind(size(labelledImage), round(ry), round(rx), repmat(numZ, length(x), 1));
        labelledImage(segmentedImageIndices) = 1;
        labelledImage(:,:,numZ)=bwlabel(watershed(double(labelledImage(:,:,numZ))));
        nZWithCells=[nZWithCells numZ];
    end
    
end

labelledImage=labelledImage-1;
zIntermediate=round(mean(nZWithCells));

%% Tracking cells and reorder cell labels.

upperZSlices=  sum(nZWithCells> zIntermediate);
lowerZSlices=  sum(nZWithCells<zIntermediate);
correctLabelledImage= zeros(size(labelledImage));
correctLabelledImage(:,:,zIntermediate)=labelledImage(:,:,zIntermediate);

[correctLabelledImage] = processZStack(labelledImage,correctLabelledImage, zIntermediate, lowerZSlices,1); % Z-slices below z-intermediate
[correctLabelledImage] = processZStack(labelledImage,correctLabelledImage, zIntermediate, upperZSlices,-1);% Z-slices above z-intermediate

%% Export excel files and calculate parameters.
correctLabelledImage;
    
    end