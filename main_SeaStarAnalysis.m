clear all

addpath('lib/Statistics');
addpath('src');

typeOfAnalysis = dir('data');
typeOfAnalysis(1:2,:)=[];

for indxAnalysis=1:size(typeOfAnalysis,1)
    
    embryoDataFiles = dir(fullfile(typeOfAnalysis(indxAnalysis,1).folder,typeOfAnalysis(indxAnalysis,1).name,'*Movies*.mat'));
    embryoMitosisFiles = dir(fullfile(typeOfAnalysis(indxAnalysis,1).folder,typeOfAnalysis(indxAnalysis,1).name,'*Mitosis*.mat'));
    embryoAverageDataFiles = dir(fullfile(typeOfAnalysis(indxAnalysis,1).folder,typeOfAnalysis(indxAnalysis,1).name,'*Movies*.mat'));
    if length(embryoDataFiles) == length(embryoMitosisFiles) && length(embryoDataFiles) > 2
        for indexFiles=1: length(embryoDataFiles)
            [allIntercalationsData,allIndxs] = extractEquinodermsData(embryoDataFiles(indexFiles),0);
            [allMitosisData,~] = extractEquinodermsData(embryoMitosisFiles(indexFiles),1);
            
            
            embryoDataFiles(indexFiles).intercalations = allIntercalationsData;
            embryoDataFiles(indexFiles).mitosis = allMitosisData;
            
            stdIntercalations =varfun(@(x) std(x,'omitnan'),allIntercalationsData);
            stdIntercalations.Properties.VariableNames=varfun(@(x) mean(x,'omitnan'),embryoDataFiles(1).intercalations).Properties.VariableNames;
            stdMitosis =varfun(@(x) std(x,'omitnan'),allMitosisData);
            stdMitosis.Properties.VariableNames=varfun(@(x) mean(x,'omitnan'),embryoDataFiles(1).mitosis).Properties.VariableNames;
  
            embryoAverageDataFiles(indexFiles).intercalations =[varfun(@(x) mean(x,'omitnan'),allIntercalationsData);stdIntercalations];
            embryoAverageDataFiles(indexFiles).mitosis =[varfun(@(x) mean(x,'omitnan'),allMitosisData);stdMitosis];
            
            if string(typeOfAnalysis(indxAnalysis,1).name) == 'all_movies'
                writetable(allMitosisData,fullfile('results',strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_',date,'_allMitosisData.xls')), 'Range','B2');
                writetable(allIntercalationsData,fullfile('results', strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_',date,'_allIntercalationsData.xls')), 'Range','B2');
                save(fullfile('results',strcat(strtok(embryoDataFiles(indexFiles).name,'.'),'_IndexIntercalations_',date,'.mat')),'allIndxs');
            end
        end
        

                
        [allTableStatsIntercalations,allTableStatsMitosis] = compareDataEmbryo(embryoDataFiles);
        

    save(fullfile('results',strcat(typeOfAnalysis(indxAnalysis,1).name,'_EmbryoData_',date,'.mat')),'embryoDataFiles','allIndxs');
    save(fullfile('results',strcat(typeOfAnalysis(indxAnalysis,1).name,'_AverageData_',date,'.mat')),'embryoAverageDataFiles');
    save(fullfile('results',strcat(typeOfAnalysis(indxAnalysis,1).name,'_Statistics_',date,'.mat')),'allTableStatsIntercalations','allTableStatsMitosis');
    
            
    end
        
end

