clear all

addpath('lib/Statistics');
addpath('src');

typeOfAnalysis = dir('data');
typeOfAnalysis(1:2,:)=[];

for indxAnalysis=1:size(typeOfAnalysis,1)
    
    embryoDataFiles = dir(fullfile(typeOfAnalysis(indxAnalysis,1).folder,typeOfAnalysis(indxAnalysis,1).name,'*Movies*.mat'));
    embryoMitosisFiles = dir(fullfile(typeOfAnalysis(indxAnalysis,1).folder,typeOfAnalysis(indxAnalysis,1).name,'*Mitosis*.mat'));
    
    if length(embryoDataFiles) == length(embryoMitosisFiles) && length(embryoDataFiles) > 2
        for indexFiles=1: length(embryoDataFiles)
            [allIntercalationsData] = extractEquinodermsData(embryoDataFiles(indexFiles),0);
            [allMitosisData] = extractEquinodermsData(embryoMitosisFiles(indexFiles),1);
            embryoDataFiles(indexFiles).intercalations = allIntercalationsData;
            embryoDataFiles(indexFiles).mitosis = allMitosisData;
            if string(typeOfAnalysis(indxAnalysis,1).name) == 'all_movies'
                writetable(allMitosisData,fullfile('results',strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_',date,'_allMitosisData.xls')), 'Range','B2');
                writetable(allIntercalationsData,fullfile('results', strcat(erase(embryoDataFiles(indexFiles).name,'.mat'),'_',date,'_allIntercalationsData.xls')), 'Range','B2');
            end
        end
        

                
        [allTableStatsIntercalations,allTableStatsMitosis] = compareDataEmbryo(embryoDataFiles);
        

    save(fullfile('results',strcat(typeOfAnalysis(indxAnalysis,1).name,'_EmbryoData_',date,'.mat')),'embryoDataFiles');
    save(fullfile('results',strcat(typeOfAnalysis(indxAnalysis,1).name,'_Statistics_',date,'.mat')),'allTableStatsIntercalations','allTableStatsMitosis');
    
            
    end
        
end

