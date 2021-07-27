function [allAfterTopology]=extractTopologyMitosis(embryoMovies,indxAfter)

afterTopology = embryoMovies(indxAfter,5);

indx2Prog=find(afterTopology == 2);
indx3AProg=find(afterTopology == 3);
indx3BProg=find(afterTopology == 3.2);
indx4Prog=find(afterTopology == 4);
indxNotDivideProg=find(afterTopology == 0);

allAfterTopology=[size(indx2Prog,1)/size(afterTopology,1) size(indx3AProg,1)/size(afterTopology,1) size(indx3BProg,1)/size(afterTopology,1) size(indx4Prog,1)/size(afterTopology,1) size(indxNotDivideProg,1)/size(afterTopology,1)];

%size(indx2Prog,1) size(indx3AProg,1) size(indx3BProg,1) size(indx4Prog,1) size(indxNotDivideProg,1);

end