clear all
addpath('lib/Statistics');
addpath('src');

embryoDataFiles = dir('data/*Movies*.mat');
embryoMitosisFiles = dir('data/*Mitosis*.mat');
if length(embryoDataFiles) == length(embryoMitosisFiles) 
for indexFiles=1: length(embryoDataFiles)
        [allIntercalationsData] = extractEquinodermsData(embryoDataFiles(indexFiles),0);
        [allMitosisData] = extractEquinodermsData(embryoMitosisFiles(indexFiles),1);
        embryoDataFiles(indexFiles).intercalations = allIntercalationsData;
        embryoDataFiles(indexFiles).mitosis = allMitosisData;
        writetable(allMitosisData,fullfile('results', strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_allMitosisData.xls')), 'Range','B2');
        writetable(allIntercalationsData,fullfile('results', strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_allIntercalationsData.xls')), 'Range','B2');
end
end


[allTableStatsIntercalations,allTableStatsMitosis] = compareDataEmbryo(embryoDataFiles);
