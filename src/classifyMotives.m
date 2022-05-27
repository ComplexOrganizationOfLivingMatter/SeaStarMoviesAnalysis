function [numberMotives,numberMotivesEachStage,meanAllTypesOfMotives,stdAllTypesOfMotives,allTypesOfMotivesEachStage,allIndxs] = classifyMotives(embryoMovies,mitosisFile)
%   Detailed explanation goes here

threshold=0.15;

if mitosisFile==1
    indxAfter=find((embryoMovies(:,1) > threshold | isnan(embryoMovies(:,1))) & embryoMovies(:,3) <= threshold);
    indxBefore=find(embryoMovies(:,1) <= threshold & (embryoMovies(:,3) > threshold | isnan(embryoMovies(:,3))));
else
    indxAfter=find(embryoMovies(:,1) <= threshold & embryoMovies(:,3) > threshold);
    indxBefore=find(embryoMovies(:,1) > threshold & embryoMovies(:,3) <= threshold);
end

indxAllInterphase=find(embryoMovies(:,1) <= threshold & embryoMovies(:,3) <= threshold);
indxIndependent=find((embryoMovies(:,1)  > threshold | isnan(embryoMovies(:,1))) & (embryoMovies(:,3) > threshold | isnan(embryoMovies(:,3))));

meanAfterMotives=mean(embryoMovies(indxAfter,1:3),1);
meanBeforeMotives=mean(embryoMovies(indxBefore,1:3),1);
meanAllInterphaseMotives=mean(embryoMovies(indxAllInterphase,1:3),1);
meanIndependentMotives=mean(embryoMovies(indxIndependent,1:3),1);

stdAfterMotives=std(embryoMovies(indxAfter,1:3),1,1);
stdBeforeMotives=std(embryoMovies(indxBefore,1:3),1,1);
stdAllInterphaseMotives=std(embryoMovies(indxAllInterphase,1:3),1,1);
stdIndependentMotives=std(embryoMovies(indxIndependent,1:3),1,1);

meanAllTypesOfMotives = [meanAfterMotives; meanBeforeMotives; meanAllInterphaseMotives; meanIndependentMotives];
stdAllTypesOfMotives = [stdAfterMotives; stdBeforeMotives; stdAllInterphaseMotives; stdIndependentMotives];
numberMotives=[size(embryoMovies(indxAfter,:),1);size(embryoMovies(indxBefore,:),1);size(embryoMovies(indxAllInterphase,:),1);size(embryoMovies(indxIndependent,:),1)];

%% Temporal distribution
allIndxs = table({indxAfter}, {indxBefore},{indxAllInterphase}, {indxIndependent});
allIndxs.Properties.VariableNames={char("After"),char("Before"), char("AllInterphase"),char("Independent")};


[numberMotivesEachStage,allTypesOfMotivesEachStage] = classifyTemporalDistribution(allIndxs,embryoMovies);

end

