addpath(genpath('src'))

close all

% if contains(folderName, strcat('\data\',TissueName,'/'))
%     files = dir(fullfile(folderName, '3d_layers_info.mat'));
% else
%     files = dir(fullfile('**/data/',TissueName,'/', folderName, '/**/Results/3d_layers_info.mat'));
% end
% nonDiscardedFiles = cellfun(@(x) contains(lower(x), 'discarded') == 0, {files.folder});
% files = files(nonDiscardedFiles);
% 
% selpath = dir(fullfile('**/data/',TissueName,'/', folderName));

[fileName, selpath] = uigetfile('*.*');
        if isempty(selpath) == 0
            starfishPostProcessing(selpath, fileName);
        end
