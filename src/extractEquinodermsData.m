function [allIntercalationsData] = extractEquinodermsData(filename)

load(fullfile(filename.folder, filename.name));
intercalationFiles = whos('file','*intercalations*');
mitosisFiles = whos('file','*mitosis*');

%% Intercalations analysis
allTypesMotives=[];
allStdTypesMotives=[];
allNumberMotives=zeros(length(intercalationFiles),4);

allTypesOfMotivesEachStage = [];
allNumberMotivesEachStage = zeros(length(intercalationFiles),6);

%% Mitosis analysis
allTypesMitosis=[];
allStdTypesMitosis=[];
allNumberMitosis=zeros(length(mitosisFiles),4);

allTypesOfMotivesEachStage = [];
allNumberMotivesEachStage = zeros(length(mitosisFiles),6);

allTopologyMitosis=zeros(length(mitosisFiles),4);

for indexMovies = 1:length(intercalationFiles)
 
    %%Intercalations
    fileNameIntercalations=intercalationFiles(indexMovies,1).name;
    [numberMotives,numberMotivesEachStage,typesOfMotives,stdTypesMotives,typesOfMotivesEachStage] = classifyMotives(eval(fileNameIntercalations));

    allTypesMotives = [allTypesMotives; typesOfMotives];
    allStdTypesMotives = [allStdTypesMotives; stdTypesMotives];
    
    allNumberMotives(indexMovies,:)=numberMotives;

    allNumberMotivesEachStage(indexMovies,:)= numberMotivesEachStage;
    allTypesOfMotivesEachStage = [allTypesOfMotivesEachStage;typesOfMotivesEachStage];
    
    %%Mitosis
%     fileNameMitosis=mitosisFiles(indexMovies,1).name;
%     [numberMitosis,numberMitosisEachStage,typesOfMitosis,stdTypesOfMitosis,typesOfMitosisEachStage] = classifyMotives(eval(fileNameMitosis));
% 
%     allTypesMitosis = [allTypesMitosis; typesOfMitosis];
%     allStdTypesMitosis = [allStdTypesMotives; stdTypesOfMitosis];
%     
%     allNumberMitosis(indexMovies,:)=numberMotives;
% 
%     allNumberMitosisEachStage(indexMovies,:)= numberMotivesEachStage;
%     allTypesOfMitosisEachStage = [allTypesOfMitosisEachStage;typesOfMitosisEachStage];
%     
%     [allAfterTopology]=extractTopologyMitosis(embryoMovies,indxAfter)
% %   allTopologyMitosis(indexMovies,:) = allAfterTopology;
end 

[afterMotives,beforeMotives,interMotives,indepMotives] = splitTypesOfMotives(allTypesMotives);
[stdAfterMotives,stdBeforeMotives,stdInterMotives,stdIndepMotives] = splitTypesOfMotives(allStdTypesMotives);
[afterMotivesEachStage,beforeMotivesEachStage,interMotivesEachStage,indepMotivesEachStage] = splitTypesOfMotives(allTypesOfMotivesEachStage);

allIntercalationsData = table(allNumberMotives, allNumberMotivesEachStage, afterMotives,beforeMotives,interMotives,indepMotives,stdAfterMotives,stdBeforeMotives,stdInterMotives,stdIndepMotives,afterMotivesEachStage,beforeMotivesEachStage,interMotivesEachStage,indepMotivesEachStage);
% allMitosisData = table(allTypesMitosis, allStdTypesOfMitosis, allNumberMitosis, allTypesOfMitosisEachStage,allNumberMitosisEachStage,allTopologyMitosis);

end
