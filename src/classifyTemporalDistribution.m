function [numberMotivesEachStage,allTypesOfMotivesEachStage] = classifyTemporalDistribution(allIndxs,embryoMovies)
%UNTITLED2 Summary of this function goes here
%%  Total motives
numberMotivesEachStage = [length(find(embryoMovies(:,4)==128)); length(find(embryoMovies(:,4)==256));length(find(embryoMovies(:,4)==512));
    length(find(embryoMovies(:,4)==1024));length(find(embryoMovies(:,4)==2048));length(find(embryoMovies(:,4)==4096))]; 
numberMotivesEachStage = numberMotivesEachStage'/length(embryoMovies(:,4));

%% Each type of motives
afterMotivesEachStage = [length(find(embryoMovies( allIndxs.After{1,1},4)==128)); length(find(embryoMovies( allIndxs.After{1,1},4)==256));length(find(embryoMovies( allIndxs.After{1,1},4)==512));
    length(find(embryoMovies( allIndxs.After{1,1},4)==1024));length(find(embryoMovies( allIndxs.After{1,1},4)==2048));length(find(embryoMovies( allIndxs.After{1,1},4)==4096))]; 

beforeMotivesEachStage = [length(find(embryoMovies(allIndxs.Before{1,1},4)==128)); length(find(embryoMovies( allIndxs.Before{1,1},4)==256));length(find(embryoMovies( allIndxs.Before{1,1},4)==512));
    length(find(embryoMovies( allIndxs.Before{1,1},4)==1024));length(find(embryoMovies( allIndxs.Before{1,1},4)==2048));length(find(embryoMovies( allIndxs.Before{1,1},4)==4096))]; 

interMotivesEachStage = [length(find(embryoMovies( allIndxs.AllInterphase{1,1},4)==128)); length(find(embryoMovies( allIndxs.AllInterphase{1,1},4)==256));length(find(embryoMovies( allIndxs.AllInterphase{1,1},4)==512));
    length(find(embryoMovies( allIndxs.AllInterphase{1,1},4)==1024));length(find(embryoMovies( allIndxs.AllInterphase{1,1},4)==2048));length(find(embryoMovies( allIndxs.AllInterphase{1,1},4)==4096))]; 

indepMotivesEachStage = [length(find(embryoMovies( allIndxs.Independent{1,1},4)==128)); length(find(embryoMovies( allIndxs.Independent{1,1},4)==256));length(find(embryoMovies( allIndxs.Independent{1,1},4)==512));
    length(find(embryoMovies( allIndxs.Independent{1,1},4)==1024));length(find(embryoMovies( allIndxs.Independent{1,1},4)==2048));length(find(embryoMovies( allIndxs.Independent{1,1},4)==4096))]; 

allTypesOfMotivesEachStage = [afterMotivesEachStage'; beforeMotivesEachStage'; interMotivesEachStage'; indepMotivesEachStage'];
allTypesOfMotivesEachStage = allTypesOfMotivesEachStage/length(embryoMovies(:,4));
end

