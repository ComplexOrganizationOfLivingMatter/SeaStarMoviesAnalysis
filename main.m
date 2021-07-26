clear all
addpath('lib/Statistics');
addpath('src');

embryoDataFiles = dir('data/*.mat');

for indexFiles=1: length(embryoDataFiles)
    
[allIntercalationsData] = extractEquinodermsData(embryoDataFiles(indexFiles,1));

embryoDataFiles(indexFiles).intercalations = allIntercalationsData;
% embryoDataFiles(indexFiles,1).topology = allTopologyMotives;
% embryoDataFiles(indexFiles,1).mitosis = allMitosisMotives;
writetable(allIntercalationsData,fullfile('results', strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_allIntercalationsData.xls')), 'Range','B2');
end


% writetable(CellularFeatures,fullfile(outputDir, 'results', 'all_Mitosis_Data.xls'), 'Range','B2');
[tableStatsIntercalations,tableStatsTimeIntervals,tableStatsTemporalDist, tableStatsTemporalDistTypeMotives] = compareDataEmbryo(embryoDataFiles);
% [tableStatsMitosis,tableStatsMitosisTimeIntervals,tableStatsMitosisTemporalDist, tableStatsTemporalDistTypeMitosis] = compareDataEmbryo(embryoDataFiles);

