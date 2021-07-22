function [allNumberMotives,allNumberMotivesNormalized,allTimeIntervals,allMiniataAfterMotives,allMiniataBeforeMotives,allMiniataInterMotives,allMiniataIndepMotives,totalPercentageMiniataMotives,allTopologyMotives] = extractEquinodermsData(filename)

load(fullfile(filename.folder, filename.name));
movieFiles = whos('file','*movie*');
allMiniataAfterMotives=zeros(length(movieFiles),3);
allMiniataBeforeMotives=zeros(length(movieFiles),3);
allMiniataInterMotives=zeros(length(movieFiles),3);
allMiniataIndepMotives=zeros(length(movieFiles),3);
allNumberMotives=zeros(length(movieFiles),4);
allNumberMotivesNormalized=zeros(length(movieFiles),4);
allTopologyMotives=zeros(length(movieFiles),4);
for indexMovies = 1:length(movieFiles)
    fileName=movieFiles(indexMovies,1).name;
    [numberMotives,AfterMotives,BeforeMotives,AllInterphaseMotives,IndependentMotives,allAfterTopology] = classifyMotives(eval(fileName));
    allMiniataAfterMotives(indexMovies,:)=AfterMotives; 
    allMiniataBeforeMotives(indexMovies,:)=BeforeMotives; 
    allMiniataInterMotives(indexMovies,:)= AllInterphaseMotives;
    allMiniataIndepMotives(indexMovies,:)= IndependentMotives;
    allNumberMotives(indexMovies,:)=numberMotives;
    allNumberMotivesNormalized(indexMovies,:)=numberMotives/sum(numberMotives);
    allTopologyMotives(indexMovies,:)= allAfterTopology;
end

allTimeIntervals = [allMiniataAfterMotives allMiniataBeforeMotives allMiniataInterMotives allMiniataIndepMotives];

allMiniataAfterMotives(all(isnan(allMiniataAfterMotives),2),:)=[];
allMiniataBeforeMotives(all(isnan(allMiniataBeforeMotives),2),:)=[];
allMiniataInterMotives(all(isnan(allMiniataInterMotives),2),:)=[];
allMiniataIndepMotives(all(isnan(allMiniataIndepMotives),2),:)=[];


totalPercentageMiniataMotives= sum(allNumberMotives/sum(sum(allNumberMotives)),1);