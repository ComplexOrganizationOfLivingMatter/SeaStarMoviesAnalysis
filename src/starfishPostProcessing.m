function [cellularFeatures] = starfishPostProcessing(files, numFile)
%PIPELINE Summary of this function goes here
%   Detailed explanation goes here
if exist(fullfile(files(numFile).folder, 'Results', 'cellularFeaturesExcel.mat'), 'file') == 0
    files(numFile).folder

mkdir(fullfile(files(numFile).folder, 'Results'));
mkdir(fullfile(files(numFile).folder, 'labelledSequence'));

%% Set Z scale and Pixel width
if exist(fullfile(files(numFile).folder, 'Results', 'zScaleOfTissue.mat'), 'file') == 0
    zScale = inputdlg('Insert z-scale of Tissue');
    zScale = str2double(zScale{1});
    
    save(fullfile(files(numFile).folder, 'Results', 'zScaleOfTissue.mat'), 'zScale');
else
    load(fullfile(files(numFile).folder, 'Results', 'zScaleOfTissue.mat'));
end

if exist(fullfile(files(numFile).folder, 'Results', 'pixelScaleOfTissue.mat'), 'file') == 0
    pixelScale = inputdlg('Insert pixel width of Tissue');
    pixelScale = str2double(pixelScale{1});
    
    save(fullfile(files(numFile).folder, 'Results', 'pixelScaleOfTissue.mat'), 'pixelScale');
else
    load(fullfile(files(numFile).folder, 'Results', 'pixelScaleOfTissue.mat'));
end

if exist(fullfile(files(numFile).folder, 'Results', '3d_layers_info.mat'), 'file') == 0
    %% Load the segmented image sequence.
    segmentedImageStack = dir(fullfile(files(numFile).folder, 'SegmentedImageSequence', '*.tif'));
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
    
    %% Export labelled ImageSequence 
    colours=[];
    selpath= strcat(files(numFile).folder,'/labelledSequence');
    colours=exportAsImageSequence(correctLabelledImage, selpath, colours);
    
    save(fullfile(files(numFile).folder, 'Results', '3d_layers_info.mat'), 'correctLabelledImage','colours', '-v7.3');
else
    load(fullfile(files(numFile).folder, 'Results', '3d_layers_info.mat'));
end
    
    
%% Export excel files and calculate parameters.


[basalLayer,apicalLayer,labelledImage_realSize]=resizeTissue(numFile,files);


validCells=1:max(max(max(labelledImage)));
noValidCells = [];
outputDir=files(numFiles.folder);

 [cellularFeatures] = calculate_CellularFeatures(apical3dInfo,basal3dInfo,apicalLayer,basalLayer,labelledImage_realSize,noValidCells,validCells,outputDir);
    
 save(fullfile(outputDir, 'Results', 'cellularFeaturesExcel.mat'), 'cellularFeatures'); 
else
    load(fullfile(files(numFile).folder, 'Results', 'cellularFeaturesExcel.mat'), 'cellularFeatures'); 
end

    
    
    end