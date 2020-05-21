function main(folderName)

addpath(genpath('src'))
addpath(genpath('lib'))

close all

    if contains(folderName, '\data\')
        files = dir(fullfile(folderName));
    else
        files = dir(fullfile('**/data/', folderName, '*.tif'));
    end
    
nonDiscardedFiles = cellfun(@(x) contains(lower(x), 'discarded') == 0, {files.folder});
files = files(nonDiscardedFiles);

totalMeanFeatures = cell([length(files) 18]);
totalStdFeatures = cell([length(files) 18]);
allGeneralInfo = cell(length(files), 4);

selpath = dir('**/data/');

    for numFile=1:length(files)
        [cellularFeatures] = starfishPostProcessing(files, numFile);
         meanFeatures = varfun(@(x) mean(x),cellularFeatures(:, 2:end));
         stdFeatures = varfun(@(x) std(x),cellularFeatures(:, 2:end));

        [meanFeatures,stdFeatures] = convertPixelsToMicrons(files,numFile,meanFeatures,stdFeatures);
         totalMeanFeatures(numFile, :) = table2cell(meanFeatures);
         totalStdFeatures(numFile, :) = table2cell(stdFeatures);
         allGeneralInfo(numFile, :) = [{fileName}, {surfaceRatio3D}, {surfaceRatio2D}, {numCells}];
    end
    
    allGeneralInfo = cell2table(allGeneralInfo, 'VariableNames', {'ID_Glands', 'SurfaceRatio3D','NCells'});
    
    save(fullfile(selpath(1).folder, 'global_3dFeatures.mat'), 'allGeneralInfo', 'totalMeanFeatures','totalStdFeatures');
    writetable(finalTable, fullfile(selpath(1).folder,'global_3dFeatures.xls'),'Range','B2');
    writetable(finalSTDTable, fullfile(selpath(1).folder,'global_3dFeatures.xls'),'Sheet', 2,'Range','B2');
end