function [tableStatsIntercalations,tableStatsTimeIntervals,tableStatsTemporalDist, tableStatsTemporalDistTypeMotives] = compareDataEmbryo(embryoDataFiles)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

%% Intercalation classification
tableStatsMiniatas=compareMeansOfMatrices(embryoDataFiles(1).intercalations.allNumberMotivesNormalized,embryoDataFiles(2).intercalations.allNumberMotivesNormalized);
tableStatsMiniataCompPictus=compareMeansOfMatrices(embryoDataFiles(2).intercalations.allNumberMotivesNormalized,embryoDataFiles(3).intercalations.allNumberMotivesNormalized);
tableStatsMiniataPictus=compareMeansOfMatrices(embryoDataFiles(1).intercalations.allNumberMotivesNormalized,embryoDataFiles(3).intercalations.allNumberMotivesNormalized);
intercalationsName=["AfterMito" "BeforeMito" "AllInterMito" "IndepMito"]';
tableStatsIntercalations= table(intercalationsName,tableStatsMiniatas.p,tableStatsMiniataPictus.p,tableStatsMiniataCompPictus.p);
tableStatsIntercalations.Properties.VariableNames={char("TypeOfIntercalation"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};

%% Comparison among intercalation, post-mitosis and pre-mitosis stage.
% for indxEmbryo=1:length(embryoDataFiles)
%     nanIndx=varfun(@(x) sum(isnan(x)), embryoDataFiles(indxEmbryo).intercalations);
%      
% end

timeMiniatasAfter=compareMeansOfMatrices(embryoDataFiles(1).intercalations.afterMotives,embryoDataFiles(2).intercalations.afterMotives);
timeMiniatasBefore=compareMeansOfMatrices(embryoDataFiles(1).intercalations.beforeMotives,embryoDataFiles(2).intercalations.beforeMotives);
timeMiniatasInter=compareMeansOfMatrices(embryoDataFiles(1).intercalations.interMotives,embryoDataFiles(2).intercalations.interMotives);
timeMiniatasIndep=compareMeansOfMatrices(embryoDataFiles(1).intercalations.indepMotives,embryoDataFiles(2).intercalations.indepMotives);

timeMiniatas=[timeMiniatasAfter.p timeMiniatasBefore.p timeMiniatasInter.p timeMiniatasIndep.p];

timeMiniataPictusAfter=compareMeansOfMatrices(embryoDataFiles(1).intercalations.afterMotives,embryoDataFiles(3).intercalations.afterMotives);
timeMiniataPictusBefore=compareMeansOfMatrices(embryoDataFiles(1).intercalations.beforeMotives,embryoDataFiles(3).intercalations.beforeMotives);
% timeMiniataPictusInter=compareMeansOfMatrices(embryoDataFiles(1).intercalations.interMotives,embryoDataFiles(3).intercalations.interMotives);
timeMiniataPictusIndep=compareMeansOfMatrices(embryoDataFiles(1).intercalations.indepMotives,embryoDataFiles(3).intercalations.indepMotives);

timeMiniataPictus=[timeMiniataPictusAfter.p timeMiniataPictusBefore.p timeMiniataPictusIndep.p];

timeMiniataCompPictusAfter=compareMeansOfMatrices(embryoDataFiles(2).intercalations.afterMotives,embryoDataFiles(3).intercalations.afterMotives);
timeMiniataCompPictusBefore=compareMeansOfMatrices(embryoDataFiles(2).intercalations.beforeMotives,embryoDataFiles(3).intercalations.beforeMotives);
% timeMiniataCompPictusInter=compareMeansOfMatrices(embryoDataFiles(2).intercalations.interMotives,embryoDataFiles(3).intercalations.interMotives);
timeMiniataCompPictusIndep=compareMeansOfMatrices(embryoDataFiles(2).intercalations.indepMotives,embryoDataFiles(3).intercalations.indepMotives);

timeMiniataCompPictus=[timeMiniataCompPictusAfter.p timeMiniataCompPictusBefore.p timeMiniataCompPictusIndep.p];

interphaseStageName=["PostMito" "Intercalation" "PreMito"]';

tableStatsTimeIntervals = table(interphaseStageName,timeMiniatas,timeMiniataPictus,timeMiniataCompPictus);
tableStatsTimeIntervals.Properties.VariableNames = {char("InterphaseStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"), char("MiniataCompVsPictus")};


%% Temporal distribution
tableStatsMiniatasEachStage=compareMeansOfMatrices(embryoDataFiles(1).intercalations.allNumberMotivesEachStage,embryoDataFiles(2).intercalations.allNumberMotivesEachStage);
tableStatsMiniataCompPictusEachStage=compareMeansOfMatrices(embryoDataFiles(2).intercalations.allNumberMotivesEachStage,embryoDataFiles(3).intercalations.allNumberMotivesEachStage);
tableStatsMiniataPictusEachStage=compareMeansOfMatrices(embryoDataFiles(1).intercalations.allNumberMotivesEachStage,embryoDataFiles(3).intercalations.allNumberMotivesEachStage);

intercalationsEachStageName=["128 cells" "256 cells" "512 cells" "1024 cells" "2048 cells" "4096 cells"]';
tableStatsTemporalDist= table(intercalationsEachStageName,tableStatsMiniatasEachStage{:,2},tableStatsMiniataPictusEachStage{:,2},tableStatsMiniataCompPictusEachStage{:,2});
tableStatsTemporalDist.Properties.VariableNames={char("TypeOfIntercalationEachStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};


temporalDistTypeMotivesMiniata = [embryoDataFiles(1).intercalations.afterMotivesEachStage embryoDataFiles(1).intercalations.beforeMotivesEachStage embryoDataFiles(1).intercalations.interMotivesEachStage embryoDataFiles(1).intercalations.indepMotivesEachStage];
temporalDistTypeMotivesMiniataComp = [embryoDataFiles(2).intercalations.afterMotivesEachStage embryoDataFiles(2).intercalations.beforeMotivesEachStage embryoDataFiles(2).intercalations.interMotivesEachStage embryoDataFiles(2).intercalations.indepMotivesEachStage];
temporalDistTypeMotivesPictus = [embryoDataFiles(3).intercalations.afterMotivesEachStage embryoDataFiles(3).intercalations.beforeMotivesEachStage embryoDataFiles(3).intercalations.interMotivesEachStage embryoDataFiles(3).intercalations.indepMotivesEachStage];

tableStatsMiniatasTdTypeOfMotives=compareMeansOfMatrices(temporalDistTypeMotivesMiniata,temporalDistTypeMotivesMiniataComp);
tableStatsMiniataCompPictusTdTypeOfMotives=compareMeansOfMatrices(temporalDistTypeMotivesMiniataComp,temporalDistTypeMotivesPictus);
tableStatsMiniataPictusTdTypeOfMotives=compareMeansOfMatrices(temporalDistTypeMotivesMiniata,temporalDistTypeMotivesPictus);

typesIntercalationsEachStageName=['After.'+intercalationsEachStageName; 'Before.'+intercalationsEachStageName; 'Inter.'+intercalationsEachStageName; 'Indep.'+intercalationsEachStageName];
tableStatsTemporalDistTypeMotives= table(typesIntercalationsEachStageName,tableStatsMiniatasTdTypeOfMotives.p,tableStatsMiniataPictusTdTypeOfMotives.p,tableStatsMiniataCompPictusTdTypeOfMotives.p);
tableStatsTemporalDistTypeMotives.Properties.VariableNames={char("TypeOfIntercalationEachStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};

% %% Topology Analysis
% topologyMiniatas = compareMeansOfMatrices(embryoDataFiles(2).topology,embryoDataFiles(3).topology);
% topologyMiniataPictus = compareMeansOfMatrices(embryoDataFiles(2).topology,embryoDataFiles(3).topology);
% topologyMiniataCompPictus = compareMeansOfMatrices(embryoDataFiles(2).topology,embryoDataFiles(3).topology);
% 
% topologyName=["2 prog" "3A prog" "3B prog" "4 prog" "incomplete mitosis"]';
% 
% tableStatsTopology =  table(topologyName,topologyMiniatas,topologyMiniataPictus,topologyMiniataCompPictus);

end

