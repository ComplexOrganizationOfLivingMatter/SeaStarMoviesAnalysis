function [numberMotives,AfterMotives,BeforeMotives,AllInterphaseMotives,IndependentMotives,allAfterTopology] = classifyMotives(embryoMovies)
%   Detailed explanation goes here

threshold=0.25;
indxAfter=find(embryoMovies(:,1) <= threshold & embryoMovies(:,3) > threshold);
indxBefore=find(embryoMovies(:,1) > threshold & embryoMovies(:,3) <= threshold);
indxAllInterphase=find(embryoMovies(:,1) <= threshold & embryoMovies(:,3) <= threshold);
indxIndependent=find(embryoMovies(:,1) > threshold & embryoMovies(:,3) > threshold);

AfterMotives=mean(embryoMovies(indxAfter,1:3),1);
BeforeMotives=mean(embryoMovies(indxBefore,1:3),1);
AllInterphaseMotives=mean(embryoMovies(indxAllInterphase,1:3),1);
IndependentMotives=mean(embryoMovies(indxIndependent,1:3),1);
numberMotives=[size(embryoMovies(indxAfter,:),1);size(embryoMovies(indxBefore,:),1);size(embryoMovies(indxAllInterphase,:),1);size(embryoMovies(indxIndependent,:),1)];

%% Topology Analysis
afterTopology = embryoMovies(indxAfter,4);

indx2Prog=find(afterTopology == '2');
indx3AProg=find(afterTopology == '3A');
indx3BProg=find(afterTopology == '3B');
indx4Prog=find(afterTopology == '4');
indxNotDivideProg=find(afterTopology == 'not');

allAfterTopology=[size(indx2Prog,1) size(indx3AProg,1) size(indx3BProg,1) size(indx4Prog,1) size(indxNotDivideProg,1);size(indx2Prog,1)/size(afterTopology) size(indx3AProg,1)/size(afterTopology) size(indx3BProg,1)/size(afterTopology) size(indx4Prog,1)/size(afterTopology) size(indxNotDivideProg,1)/size(afterTopology)];

%% Temporal distribution


end

