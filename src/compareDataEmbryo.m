function [allTableStatsIntercalations,allTableStatsMitosis] = compareDataEmbryo(embryoDataFiles)
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
timeMiniataPictusInter=compareMeansOfMatrices(embryoDataFiles(1).intercalations.interMotives,embryoDataFiles(3).intercalations.interMotives);
timeMiniataPictusIndep=compareMeansOfMatrices(embryoDataFiles(1).intercalations.indepMotives,embryoDataFiles(3).intercalations.indepMotives);

timeMiniataPictus=[timeMiniataPictusAfter.p timeMiniataPictusBefore.p timeMiniataPictusInter.p timeMiniataPictusIndep.p];

timeMiniataCompPictusAfter=compareMeansOfMatrices(embryoDataFiles(2).intercalations.afterMotives,embryoDataFiles(3).intercalations.afterMotives);
timeMiniataCompPictusBefore=compareMeansOfMatrices(embryoDataFiles(2).intercalations.beforeMotives,embryoDataFiles(3).intercalations.beforeMotives);
timeMiniataCompPictusInter=compareMeansOfMatrices(embryoDataFiles(2).intercalations.interMotives,embryoDataFiles(3).intercalations.interMotives);
timeMiniataCompPictusIndep=compareMeansOfMatrices(embryoDataFiles(2).intercalations.indepMotives,embryoDataFiles(3).intercalations.indepMotives);

timeMiniataCompPictus=[timeMiniataCompPictusAfter.p timeMiniataCompPictusBefore.p timeMiniataCompPictusInter.p timeMiniataCompPictusIndep.p];

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

%% Mitosis classification
tableStatsMiniatas=compareMeansOfMatrices(embryoDataFiles(1).mitosis.allNumberMotivesNormalized,embryoDataFiles(2).mitosis.allNumberMotivesNormalized);
tableStatsMiniataCompPictus=compareMeansOfMatrices(embryoDataFiles(2).mitosis.allNumberMotivesNormalized,embryoDataFiles(3).mitosis.allNumberMotivesNormalized);
tableStatsMiniataPictus=compareMeansOfMatrices(embryoDataFiles(1).mitosis.allNumberMotivesNormalized,embryoDataFiles(3).mitosis.allNumberMotivesNormalized);
mitosisName=["AfterMito" "BeforeMito" "Before&AfterMito" "NotRelatedMito"]';
tableStatsMitosis= table(mitosisName,tableStatsMiniatas.p,tableStatsMiniataPictus.p,tableStatsMiniataCompPictus.p);
tableStatsMitosis.Properties.VariableNames={char("TypeOfMitosis"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};

%% Comparison among mitosis, post-mitosis and pre-mitosis stage.

mitosisMiniatasAfter=compareMeansOfMatrices(embryoDataFiles(1).mitosis.afterMotives(:,2:end),embryoDataFiles(2).mitosis.afterMotives(:,2:end));
mitosisMiniatasBefore=compareMeansOfMatrices(embryoDataFiles(1).mitosis.beforeMotives(:,1:2),embryoDataFiles(2).mitosis.beforeMotives(:,1:2));
mitosisMiniatasBefAft=compareMeansOfMatrices(embryoDataFiles(1).mitosis.interMotives,embryoDataFiles(2).mitosis.interMotives);
mitosisMiniatasIndep=compareMeansOfMatrices(embryoDataFiles(1).mitosis.indepMotives,embryoDataFiles(2).mitosis.indepMotives);

mitosisMiniatas=[vertcat(NaN,mitosisMiniatasAfter.p) vertcat(mitosisMiniatasBefore.p,NaN) mitosisMiniatasBefAft.p vertcat(NaN,mitosisMiniatasIndep.p(2),NaN)];

mitosisMiniataPictusAfter=compareMeansOfMatrices(embryoDataFiles(1).mitosis.afterMotives(:,2:end),embryoDataFiles(3).mitosis.afterMotives(:,2:end));
mitosisMiniataPictusBefore=compareMeansOfMatrices(embryoDataFiles(1).mitosis.beforeMotives(:,1:2),embryoDataFiles(3).mitosis.beforeMotives(:,1:2));
mitosisMiniataPictusBeftAft=compareMeansOfMatrices(embryoDataFiles(1).mitosis.interMotives,embryoDataFiles(3).mitosis.interMotives);
mitosisMiniataPictusIndep=compareMeansOfMatrices(embryoDataFiles(1).mitosis.indepMotives,embryoDataFiles(3).mitosis.indepMotives);

mitosisMiniataPictus=[vertcat(NaN,mitosisMiniataPictusAfter.p)  vertcat(mitosisMiniataPictusBefore.p,NaN) mitosisMiniataPictusBeftAft.p vertcat(NaN,mitosisMiniataPictusIndep.p(2),NaN)];

mitosisMiniataCompPictusAfter=compareMeansOfMatrices(embryoDataFiles(2).mitosis.afterMotives(:,2:end),embryoDataFiles(3).mitosis.afterMotives(:,2:end));
mitosisMiniataCompPictusBefore=compareMeansOfMatrices(embryoDataFiles(2).mitosis.beforeMotives(:,1:2),embryoDataFiles(3).mitosis.beforeMotives(:,1:2));
mitosisMiniataCompPictusBeftAft=compareMeansOfMatrices(embryoDataFiles(2).mitosis.interMotives,embryoDataFiles(3).mitosis.interMotives);
mitosisMiniataCompPictusIndep=compareMeansOfMatrices(embryoDataFiles(2).mitosis.indepMotives,embryoDataFiles(3).mitosis.indepMotives);

mitosisMiniataCompPictus=[vertcat(NaN,mitosisMiniataCompPictusAfter.p) vertcat(mitosisMiniataCompPictusBefore.p,NaN) mitosisMiniataCompPictusBeftAft.p vertcat(NaN,mitosisMiniataCompPictusIndep.p(2),NaN)];

mitosisStageName=["PreMito" "Mito" "PostMito"]';

tableStatsMitosisTimeIntervals = table(mitosisStageName,mitosisMiniatas,mitosisMiniataPictus,mitosisMiniataCompPictus);
tableStatsMitosisTimeIntervals.Properties.VariableNames = {char("MitosisStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"), char("MiniataCompVsPictus")};

%% Temporal distribution mitosis
tableStatsMitosisMiniatasEachStage=compareMeansOfMatrices(embryoDataFiles(1).mitosis.allNumberMotivesEachStage,embryoDataFiles(2).mitosis.allNumberMotivesEachStage);
tableStatsMitosisMiniataCompPictusEachStage=compareMeansOfMatrices(embryoDataFiles(2).mitosis.allNumberMotivesEachStage,embryoDataFiles(3).mitosis.allNumberMotivesEachStage);
tableStatsMitosisMiniataPictusEachStage=compareMeansOfMatrices(embryoDataFiles(1).mitosis.allNumberMotivesEachStage,embryoDataFiles(3).mitosis.allNumberMotivesEachStage);
mitosisEachStageName=["128 cells" "256 cells" "512 cells" "1024 cells" "2048 cells" "4096 cells"]';
tableStatsMitosisTemporalDist= table(mitosisEachStageName,tableStatsMitosisMiniatasEachStage{:,2},tableStatsMitosisMiniataPictusEachStage{:,2},tableStatsMitosisMiniataCompPictusEachStage{:,2});
tableStatsMitosisTemporalDist.Properties.VariableNames={char("TypeOfMitosisEachStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};


temporalDistTypeMitosisMiniata = [embryoDataFiles(1).mitosis.afterMotivesEachStage embryoDataFiles(1).mitosis.beforeMotivesEachStage embryoDataFiles(1).mitosis.interMotivesEachStage embryoDataFiles(1).mitosis.indepMotivesEachStage];
temporalDistTypeMitosisMiniataComp = [embryoDataFiles(2).mitosis.afterMotivesEachStage embryoDataFiles(2).mitosis.beforeMotivesEachStage embryoDataFiles(2).mitosis.interMotivesEachStage embryoDataFiles(2).mitosis.indepMotivesEachStage];
temporalDistTypeMitosisPictus = [embryoDataFiles(3).mitosis.afterMotivesEachStage embryoDataFiles(3).mitosis.beforeMotivesEachStage embryoDataFiles(3).mitosis.interMotivesEachStage embryoDataFiles(3).mitosis.indepMotivesEachStage];

tableStatsMiniatasTdTypeOfMitosis=compareMeansOfMatrices(temporalDistTypeMitosisMiniata,temporalDistTypeMitosisMiniataComp);
tableStatsMiniataCompPictusTdTypeOfMitosis=compareMeansOfMatrices(temporalDistTypeMitosisMiniataComp,temporalDistTypeMitosisPictus);
tableStatsMiniataPictusTdTypeOfMitosis=compareMeansOfMatrices(temporalDistTypeMitosisMiniata,temporalDistTypeMitosisPictus);

typesMitosisEachStageName=['After.'+mitosisEachStageName; 'Before.'+mitosisEachStageName; 'Before&After.'+mitosisEachStageName; 'NotRel.'+mitosisEachStageName];
tableStatsTemporalDistTypeMitosis= table(typesMitosisEachStageName,tableStatsMiniatasTdTypeOfMitosis.p,tableStatsMiniataPictusTdTypeOfMitosis.p,tableStatsMiniataCompPictusTdTypeOfMitosis.p);
tableStatsTemporalDistTypeMitosis.Properties.VariableNames={char("TypeOfMitosisEachStage"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};


%% Topology Analysis
topologyMiniatas = compareMeansOfMatrices(table2array(embryoDataFiles(1).mitosis(:,end)),table2array(embryoDataFiles(2).mitosis(:,end)));
topologyMiniataPictus = compareMeansOfMatrices(table2array(embryoDataFiles(1).mitosis(:,end)),table2array(embryoDataFiles(3).mitosis(:,end)));
topologyMiniataCompPictus = compareMeansOfMatrices(table2array(embryoDataFiles(2).mitosis(:,end)),table2array(embryoDataFiles(3).mitosis(:,end)));

topologyName=["2 prog" "3A prog" "3B prog" "4 prog" "incomplete mitosis"]';

tableStatsTopology =  table(topologyName,topologyMiniatas.p,topologyMiniataPictus.p,topologyMiniataCompPictus.p);
tableStatsTopology.Properties.VariableNames={char("NumberOfProgenitors"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};

allTableStatsIntercalations = {tableStatsIntercalations,tableStatsTimeIntervals,tableStatsTemporalDist,tableStatsTemporalDistTypeMotives};
allTableStatsMitosis = {tableStatsMitosis,tableStatsMitosisTimeIntervals,tableStatsMitosisTemporalDist,tableStatsTemporalDistTypeMitosis,tableStatsTopology};


end

