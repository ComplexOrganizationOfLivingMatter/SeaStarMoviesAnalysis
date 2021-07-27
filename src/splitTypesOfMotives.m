function [after,before,inter,indep] = splitTypesOfMotives(typesOfMotives)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

after=typesOfMotives(1:4:end,:);
before=typesOfMotives(2:4:end,:);
inter=typesOfMotives(3:4:end,:);
indep=typesOfMotives(4:4:end,:);

end

