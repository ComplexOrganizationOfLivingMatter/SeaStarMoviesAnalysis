clear all
addpath('lib/Statistics');
addpath('src');

embryoDataFiles = dir('data/*.mat');

for indexFiles=1: length(embryoDataFiles)
    
[allNumberMotives,allNumberMotivesNormalized,allTimeIntervals,allMiniataAfterMotives,allMiniataBeforeMotives,allMiniataInterMotives,allMiniataIndepMotives,percentageMiniataMotives] = extractEquinodermsData(embryoDataFiles(indexFiles,1));

embryoDataFiles(indexFiles,1).data={allNumberMotivesNormalized,allTimeIntervals,percentageMiniataMotives,allNumberMotives;allMiniataAfterMotives,allMiniataBeforeMotives,allMiniataInterMotives,allMiniataIndepMotives};

    
end


[tableStatsTimeIntervals,tableStatsIntercalations] = compareDataEmbryo(embryoDataFiles);
