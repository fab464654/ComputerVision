function M = intersect_base(PPM,m)
%_INTERSECT_LE Intersection with Linear-Eigen algorithm
%
%M = intersect(PPM,m) calcola la ricostruzione 3D dato in insieme di
%matrici di proiezione prospettica (PPM) e un insieme di punti
%immagine corrispondenti.

% Algorithm: Linear-Eigen

% Author: Andrea Fusiello

%fprintf('LE\n');

siz = size(m);

numP = siz(2);
numV = siz(3);



% versione vecchia, senza raffinamento iterativo


 M = [];
   for i = 1:numP  
     A=[];
       for view = 1:numV
         PPM(:,:,view) = PPM(:,:,view)./norm(PPM(3,1:3,view));
         A =  [A
          PPM(1,:,view) - m(1,i,view)*PPM(3,:,view)
           PPM(2,:,view) - m(2,i,view)*PPM(3,:,view)];
       end   
    
    x = ns(A);
    M =[M x(1:3)./x(4)];
    A;
 end
 

