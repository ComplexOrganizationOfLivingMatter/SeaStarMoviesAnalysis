function [allMotivesData,allIndxs] = extractEquinodermsData(filename,checkFile)

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

allAfterTopologyMitosis = zeros(length(motivesFiles),5);
allBeforeAfterTopologyMitosis = zeros(length(motivesFiles),5);

allIndxs=table();

for indexMovies = 1:length(motivesFiles)
 
    fileNameMotives=motivesFiles(indexMovies,1).name;
    [numberMotives,numberMotivesEachStage,typesOfMotives,stdTypesMotives,typesOfMotivesEachStage,indxsEachType] = classifyMotives(eval(fileNameMotives),checkFile);

    allTypesMotives = [allTypesMotives; typesOfMotives];
    allStdTypesMotives = [allStdTypesMotives; stdTypesMotives];
    
    allNumberMotives(indexMovies,:)=numberMotives;

    allNumberMotivesEachStage(indexMovies,:)= numberMotivesEachStage;
    allTypesOfMotivesEachStage = [allTypesOfMotivesEachStage;typesOfMotivesEachStage];
    
    if checkFile
       [allAfterTopology] = extractTopologyMitosis(eval(fileNameMotives), cell2mat(indxsEachType.After));
       [allBeforeAfterTopology] = extractTopologyMitosis(eval(fileNameMotives), cell2mat(indxsEachType.AllInterphase));
       allAfterTopologyMitosis(indexMovies,:) = allAfterTopology;
       allBeforeAfterTopologyMitosis(indexMovies,:) = allBeforeAfterTopology;
    end
    
     allIndxs(indexMovies,:) = indxsEachType;
    
end 

[afterMotives,beforeMotives,interMotives,indepMotives] = splitTypesOfMotives(allTypesMotives);
[stdAfterMotives,stdBeforeMotives,stdInterMotives,stdIndepMotives] = splitTypesOfMotives(allStdTypesMotives);
[afterMotivesEachStage,beforeMotivesEachStage,interMotivesEachStage,indepMotivesEachStage] = splitTypesOfMotives(allTypesOfMotivesEachStage);
allNumberMotivesNormalized = allNumberMotives./sum(allNumberMotives,2);

allMotivesData = table(allNumberMotives,allNumberMotivesNormalized, allNumberMotivesEachStage, afterMotives,beforeMotives,interMotives,indepMotives,stdAfterMotives,stdBeforeMotives,stdInterMotives,stdIndepMotives,afterMotivesEachStage,beforeMotivesEachStage,interMotivesEachStage,indepMotivesEachStage);
    if checkFile
        allMotivesData = [allMotivesData,table(allAfterTopologyMitosis),table(allBeforeAfterTopologyMitosis)];
    end
end
