function [tableStatsTimeIntervals,tableStatsIntercalations] = compareDataEmbryo(embryoDataFiles)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


tableStatsMiniatas=compareMeansOfMatrices(embryoDataFiles(2).data{1,1},embryoDataFiles(1).data{1,1});
tableStatsMiniataCompPictus=compareMeansOfMatrices(embryoDataFiles(1).data{1,1},embryoDataFiles(3).data{1,1});
tableStatsMiniataPictus=compareMeansOfMatrices(embryoDataFiles(2).data{1,1},embryoDataFiles(3).data{1,1});
intercalationsName=["AfterMito" "BeforeMito" "AllInterMito" "IndepMito"]';
tableStatsIntercalations= table(intercalationsName,tableStatsMiniatas{:,2},tableStatsMiniataPictus{:,2},tableStatsMiniataCompPictus{:,2});

tableStatsIntercalations.Properties.VariableNames={char("TypeOfIntercalation"),char("MiniataVsMiniataComp"), char("MiniataVsPictus"),char("MiniataCompVsPictus")};

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

% 
% 
end

