   
Filename = dir('*.xls');
Currentfile = Filename(1,1).name;

positions= xlsread(Currentfile,'Position');
X = positions(:,1);
Y = positions(:,2);
Z = positions(:,3);

    DT = delaunayTriangulation(X,Y,Z);
    
    edgeIndex = edges(DT);                           %# Triangulation edge indices
    midpts = [mean(X(edgeIndex),2),...
        mean(Y(edgeIndex),2),mean(Z(edgeIndex),2)]; %# Find the midpoints of the edges
    nearIndex = nearestNeighbor(DT,midpts);          %# Find the vertex nearest the midpoints
    keepIndex = (nearIndex == edgeIndex(:,1))|(nearIndex == edgeIndex(:,2));     %# Find the edges where the   
    
    FiltEdgeIndex = edgeIndex(keepIndex,:); 
    neighbors= []; 
    
%       for n = 1:size([DT.Points],1)
%         pointEdges = [FiltEdgeIndex((n == FiltEdgeIndex(:,1)),2); FiltEdgeIndex((n == FiltEdgeIndex(:,2)),1)];
%        %neighbors(n).set = [DATA(n,7),DATA(pointEdges,7)'];
%        %spots(TimeIDs(n)).neighborSet = [DATA(pointEdges,7)']; %ImarisID of the neighbors
%        
%        nXYZ = [positions(n,1:3)];
%        neighXYZ = [positions(pointEdges,1:3)];
%        Distance = pdist2(nXYZ,neighXYZ);
%        spots(n).VoronoiMeanDist = mean2(Distance);
%        spots(n).VoronoiNN = size(neighXYZ,1);
%       end
     
      alldistances = [];
      for n = 1:size(FiltEdgeIndex,1)
          point1 = positions(FiltEdgeIndex(n,1),1:3);
          point2 = positions(FiltEdgeIndex(n,2),1:3);
          edgelength = pdist2(point1,point2);
          alldistances = [alldistances;edgelength];
      end
 
 filename = ['AllDistances',Currentfile];     
 xlswrite(filename,alldistances);
      