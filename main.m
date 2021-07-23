clear all
addpath('lib/Statistics');
addpath('src');

embryoDataFiles = dir('data/*.mat');

for indexFiles=1: length(embryoDataFiles)
    
[allIntercalationsData] = extractEquinodermsData(embryoDataFiles(indexFiles,1));

embryoDataFiles(indexFiles,1).intercalations = {allIntercalationsData.allNumberMotives,allIntercalationsData.afterMotives,allIntercalationsData.beforeMotives,allIntercalationsData.interMotives,allIntercalationsData.indepMotives,
    allIntercalationsData.stdAfterMotives,allIntercalationsData.stdBeforeMotives,allIntercalationsData.stdInterMotives,allIntercalationsData.stdIndepMotives};
% embryoDataFiles(indexFiles,1).topology = allTopologyMotives;
embryoDataFiles(indexFiles,1).distribution = {allIntercalationsData.allNumberMotivesEachStage,allIntercalationsData.afterMotivesEachStage,allIntercalationsData.beforeMotivesEachStage,allIntercalationsData.interMotivesEachStage,allIntercalationsData.indepMotivesEachStage};
    
% embryoDataFiles(indexFiles,1).mitosis = allMitosisMotives;

end


[tableStatsTimeIntervals,tableStatsIntercalations,tableStatsTopology] = compareDataEmbryo(embryoDataFiles);
