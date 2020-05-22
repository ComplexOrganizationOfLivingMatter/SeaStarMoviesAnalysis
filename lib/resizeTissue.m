function [basalLayer,apicalLayer,labelledImage_realSize]=resizeTissue(numFile,files)

if exist(fullfile(files(numFile).folder, 'realSize3dLayers.mat'), 'file') == 0
    
    %% Step 1: Creating image with its real size
    load(fullfile(files(numFile).folder, 'Results', 'zScaleOfTissue.mat'))
    load(fullfile(files(numFile).folder, 'Results', '3d_layers_info.mat'))%, 'labelledImage_realSize', 'lumenImage_realSize');
    
    labelledImage_realSize  = imresize3(correctLabelledImage, [1024 1024 zScale*size(correctLabelledImage,3)], 'nearest');
     [x,y,z] = ind2sub(size(labelledImage_realSize),find(labelledImage_realSize>0));
     pixelLocations = [x, y, z];
     for numCell=1:max(max(max(labelledImage_realSize)))
     [labelledImage_realSize] = smoothObject(labelledImage_realSize,pixelLocations, numCell);
     end 
    [basalLayer,apicalLayer] = getApicalAndBasalFrom3DImage(labelledImage_realSize);
    
    layers3d=[{apicalLayer},{basalLayer}];
    
    %% Step 2: Getting the perimeter of the basal and apical layers of the image with its real size
    for iteration=1:2
        
        img3dComplete = labelledImage_realSize;
        img3d_original = cell2mat(layers3d(iteration));
        
        [allX,allY,allZ]=ind2sub(size(img3dComplete),find(img3dComplete>0));
        img3d_originalCropped = img3d_original(min(allX):max(allX),min(allY):max(allY),min(allZ):max(allZ));
        img3dComplete_Cropped = img3dComplete(min(allX):max(allX),min(allY):max(allY),min(allZ):max(allZ));
        
        sizeImg3d = size(img3d_originalCropped);
        [~, indices] = sort(sizeImg3d);
        img3d_original = permute(img3d_originalCropped, indices);
        img3dComplete = permute(img3dComplete_Cropped, indices);
        tipValue = 20;
        img3d_original = addTipsImg3D(tipValue, img3d_original);
        img3dComplete = addTipsImg3D(tipValue, img3dComplete);
        
        img3dComplete = double(img3dComplete);
        img3d = double(img3d_original);
        
        if iteration == 1
            [apicalLayer] = calculatePerimOf3DImage(img3d, img3dComplete);
        else
            [basalLayer] = calculatePerimOf3DImage(img3d, img3dComplete);
        end
        
    end
    save(fullfile(files(numFile).folder, 'realSize3dLayers.mat'), 'labelledImage_realSize','apicalLayer','basalLayer', '-v7.3');
    
else
    load(fullfile(files(numFile).folder, 'realSize3dLayers.mat'))
end

end