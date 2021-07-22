clear all
addpath('lib/Statistics');
addpath('src');

embryoDataFiles = dir('data/*.mat');

for indexFiles=1: length(embryoDataFiles)
    
[allNumberMotives,allNumberMotivesNormalized,allTimeIntervals,allMiniataAfterMotives,allMiniataBeforeMotives,allMiniataInterMotives,allMiniataIndepMotives,percentageMiniataMotives,allTopologyMotives,allTemporalDistributionMotives] = extractEquinodermsData(embryoDataFiles(indexFiles,1));

embryoDataFiles(indexFiles,1).intercalations = {allNumberMotivesNormalized,allTimeIntervals,percentageMiniataMotives,allNumberMotives;allMiniataAfterMotives,allMiniataBeforeMotives,allMiniataInterMotives,allMiniataIndepMotives};
embryoDataFiles(indexFiles,1).topology = allTopologyMotives;
embryoDataFiles(indexFiles,1).distribution = allTemporalDistributionMotives;
embryoDataFiles(indexFiles,1).mitosis=

end


[tableStatsTimeIntervals,tableStatsIntercalations,tableStatsTopology] = compareDataEmbryo(embryoDataFiles);
