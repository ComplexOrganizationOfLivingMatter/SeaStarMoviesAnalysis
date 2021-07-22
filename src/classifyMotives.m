function [numberMotives,AfterMotives,BeforeMotives,AllInterphaseMotives,IndependentMotives] = classifyMotives(embryoMovies)
%   Detailed explanation goes here

threshold=0.25;
indxAfter=find(embryoMovies(:,1) <= threshold & embryoMovies(:,3) > threshold);
indxBefore=find(embryoMovies(:,1) > threshold & embryoMovies(:,3) <= threshold);
indxAllInterphase=find(embryoMovies(:,1) <= threshold & embryoMovies(:,3) <= threshold);
indxIndependent=find(embryoMovies(:,1) > threshold & embryoMovies(:,3) > threshold);

AfterMotives=mean(embryoMovies(indxAfter,:),1);

BeforeMotives=mean(embryoMovies(indxBefore,:),1);
AllInterphaseMotives=mean(embryoMovies(indxAllInterphase,:),1);
IndependentMotives=mean(embryoMovies(indxIndependent,:),1);
numberMotives=[size(embryoMovies(indxAfter,:),1);size(embryoMovies(indxBefore,:),1);size(embryoMovies(indxAllInterphase,:),1);size(embryoMovies(indxIndependent,:),1)];

end

