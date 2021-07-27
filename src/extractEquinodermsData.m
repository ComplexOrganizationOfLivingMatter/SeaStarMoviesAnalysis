function [allMotivesData] = extractEquinodermsData(filename,checkFile)

load(fullfile(filename.folder, filename.name));
    if checkFile 
        motivesFiles = whos('file','*mitosis*');
    else
        motivesFiles = whos('file','*intercalations*');
    end

%% Motives analysis
allTypesMotives=[];
allStdTypesMotives=[];
allNumberMotives=zeros(length(motivesFiles),4);

allTypesOfMotivesEachStage = [];
allNumberMotivesEachStage = zeros(length(motivesFiles),6);

allTopologyMitosis = zeros(length(motivesFiles),5);

for indexMovies = 1:length(motivesFiles)
 
    fileNameMotives=motivesFiles(indexMovies,1).name;
    [numberMotives,numberMotivesEachStage,typesOfMotives,stdTypesMotives,typesOfMotivesEachStage,indxAfter] = classifyMotives(eval(fileNameMotives),checkFile);

    allTypesMotives = [allTypesMotives; typesOfMotives];
    allStdTypesMotives = [allStdTypesMotives; stdTypesMotives];
    
    allNumberMotives(indexMovies,:)=numberMotives;

    allNumberMotivesEachStage(indexMovies,:)= numberMotivesEachStage;
    allTypesOfMotivesEachStage = [allTypesOfMotivesEachStage;typesOfMotivesEachStage];
    
    if checkFile
       [allAfterTopology] = extractTopologyMitosis(eval(fileNameMotives),indxAfter);
       allTopologyMitosis(indexMovies,:) = allAfterTopology;
    end
    
end 

[afterMotives,beforeMotives,interMotives,indepMotives] = splitTypesOfMotives(allTypesMotives);
[stdAfterMotives,stdBeforeMotives,stdInterMotives,stdIndepMotives] = splitTypesOfMotives(allStdTypesMotives);
[afterMotivesEachStage,beforeMotivesEachStage,interMotivesEachStage,indepMotivesEachStage] = splitTypesOfMotives(allTypesOfMotivesEachStage);
allNumberMotivesNormalized = allNumberMotives./sum(allNumberMotives,2);

allMotivesData = table(allNumberMotives,allNumberMotivesNormalized, allNumberMotivesEachStage, afterMotives,beforeMotives,interMotives,indepMotives,stdAfterMotives,stdBeforeMotives,stdInterMotives,stdIndepMotives,afterMotivesEachStage,beforeMotivesEachStage,interMotivesEachStage,indepMotivesEachStage);
    if checkFile
        allMotivesData = [allMotivesData,table(allTopologyMitosis)];
    end
end
