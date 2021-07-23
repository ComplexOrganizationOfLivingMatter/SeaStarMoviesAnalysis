function [tableStatsTimeIntervals,tableStatsIntercalations,tableStatsTemporalDistribution] = compareDataEmbryo(embryoDataFiles)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%% Intercalation classification
tableStatsMiniatas=compareMeansOfMatrices(embryoDataFiles(1).intercalations.allNumberMotivesNormalized,embryoDataFiles(2).allNumberMotivesNormalized);
tableStatsMiniataCompPictus=compareMeansOfMatrices(embryoDataFiles(2).allNumberMotivesNormalized,embryoDataFiles(3).allNumberMotivesNormalized);
tableStatsMiniataPictus=compareMeansOfMatrices(embryoDataFiles(1).allNumberMotivesNormalized,embryoDataFiles(3).allNumberMotivesNormalized);
intercalationsName=["AfterMito" "BeforeMito" "AllInterMito" "IndepMito"]';
tableStatsIntercalations= table(intercalationsName,tableStatsMiniatas{:,2},tableStatsMiniataPictus{:,2},tableStatsMiniataCompPictus{:,2});

tableStatsIntercalations.Properties.VariableNames={char("TypeOfIntercalation"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};

tableStatsMiniatasEachStage=compareMeansOfMatrices(embryoDataFiles(1).intercalations.allNumberMotivesNormalized,embryoDataFiles(2).allNumberMotivesNormalized);
tableStatsMiniataCompPictusEachStage=compareMeansOfMatrices(embryoDataFiles(2).allNumberMotivesNormalized,embryoDataFiles(3).allNumberMotivesNormalized);
tableStatsMiniataPictusEachStage=compareMeansOfMatrices(embryoDataFiles(1).allNumberMotivesNormalized,embryoDataFiles(3).allNumberMotivesNormalized);
intercalationsEachStageName=["128 cells" "256 cells" "512 cells" "1024 cells" "2048 cells" "4096 cells"]';
tableStatsIntercalations= table(intercalationsEachStageName,tableStatsMiniatasEachStage{:,2},tableStatsMiniataPictusEachStage{:,2},tableStatsMiniataCompPictusEachStage{:,2});

tableStatsIntercalations.Properties.VariableNames={char("TypeOfIntercalationEachStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};
%%% TIME STAGES 
%% Miniata wild type Vs Miniata Comprresed
timeMiniatasAfter=compareMeansOfMatrices(embryoDataFiles(2).data{2,1},embryoDataFiles(1).data{2,1});
timeMiniatasBefore=compareMeansOfMatrices(embryoDataFiles(2).data{2,2},embryoDataFiles(1).data{2,2});
timeMiniatasInter=compareMeansOfMatrices(embryoDataFiles(2).data{2,3},embryoDataFiles(1).data{2,3});
timeMiniatasIndep=compareMeansOfMatrices(embryoDataFiles(2).data{2,4},embryoDataFiles(1).data{2,4});

timeMiniatas=[timeMiniatasAfter.p timeMiniatasBefore.p timeMiniatasInter.p timeMiniatasIndep.p];
%% Miniata Comprresed Vs Pictus
timeMiniataCompPictusAfter=compareMeansOfMatrices(embryoDataFiles(1).data{2,1},embryoDataFiles(3).data{2,1});
timeMiniataCompPictusBefore=compareMeansOfMatrices(embryoDataFiles(1).data{2,2},embryoDataFiles(3).data{2,2});
% timeMiniataCompPictusInter=compareMeansOfMatrices(embryoDataFiles(1).data{2,3},embryoDataFiles(3).data{2,3});
timeMiniataCompPictusIndep=compareMeansOfMatrices(embryoDataFiles(1).data{2,4},embryoDataFiles(3).data{2,4});

timeMiniataCompPictus=[timeMiniataCompPictusAfter.p timeMiniataCompPictusBefore.p timeMiniataCompPictusIndep.p];
%% Miniata wild type Vs Pictus
timeMiniataPictusAfter=compareMeansOfMatrices(embryoDataFiles(2).data{2,1},embryoDataFiles(3).data{2,1});
timeMiniataPictusBefore=compareMeansOfMatrices(embryoDataFiles(2).data{2,2},embryoDataFiles(3).data{2,2});
% timeMiniataPictusInter=compareMeansOfMatrices(embryoDataFiles(2).data{2,3},embryoDataFiles(3).data{2,3});
timeMiniataPictusIndep=compareMeansOfMatrices(embryoDataFiles(2).data{2,4},embryoDataFiles(3).data{2,4});

timeMiniataPictus=[timeMiniataPictusAfter.p timeMiniataPictusBefore.p timeMiniataPictusIndep.p];

interphaseStageName=["PostMito" "Intercalation" "PreMito"]';
% 
tableStatsTimeIntervals = table(interphaseStageName,timeMiniatas,timeMiniataPictus,timeMiniataCompPictus);
tableStatsTimeIntervals.Properties.VariableNames = {char("InterphaseStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"), char("MiniataCompVsPictus")};

% %% Topology Analysis
% topologyMiniatas = compareMeansOfMatrices(embryoDataFiles(2).topology,embryoDataFiles(3).topology);
% topologyMiniataPictus = compareMeansOfMatrices(embryoDataFiles(2).topology,embryoDataFiles(3).topology);
% topologyMiniataCompPictus = compareMeansOfMatrices(embryoDataFiles(2).topology,embryoDataFiles(3).topology);
% 
% topologyName=["2 prog" "3A prog" "3B prog" "4 prog" "incomplete mitosis"]';
% 
% tableStatsTopology =  table(topologyName,topologyMiniatas,topologyMiniataPictus,topologyMiniataCompPictus);

%%Temporal distribution
temporalDistributionMiniatas = compareMeansOfMatrices(embryoDataFiles(2).distribution,embryoDataFiles(3).distribution);
temporalDistributionMiniataPictus = compareMeansOfMatrices(embryoDataFiles(2).distribution,embryoDataFiles(3).distribution);
temporalDistributionMiniataCompPictus = compareMeansOfMatrices(embryoDataFiles(2).distribution,embryoDataFiles(3).distribution);

temporalDistributionName=["128 cells" "256 cells" "512 cells" "1024 cells" "2048 cells" "4096 cells"]';

tableStatsTemporalDistribution =  table(temporalDistributionName,temporalDistributionMiniatas,temporalDistributionMiniataPictus,temporalDistributionMiniataCompPictus);

end

