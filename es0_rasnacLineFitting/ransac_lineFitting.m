
%This script was developed in order to understand the RANSAC algorithm.
%Also, it's useful to support and better understand the use of RANSAC
%inside the mosaicing project.

clear; close all; clc;

%Genero i punti allineati come una retta (inliers)
%impongo la retta y=x
x = randi([-50 50],150,1);

due_circa = 2 + (rand(150,1) - 0.5)/1.5; %numeri molto vicini al 2

y = due_circa.*x;


%Genero i punti di disturbo (outliers)
x_agl = -1 + 2*rand(30,1);
y_agl = sqrt(2-x_agl.^2).*rand(30,1) + 100; %30 punti aglomerati

x_sparsi = cat(1,randi([-150 -80],10,1),randi([80 200],10,1));
y_sparsi = randi([-100 100],20,1); %20 punti sparsi

x_out = cat(1,x_agl,x_sparsi);
y_out = cat(1,y_agl,y_sparsi); 

%Grafico i punti 
for i = 1:150; j = 1:50;    
    plot(x(i),y(i),'.');    
    plot(x_out(j),y_out(j),'r*');
    hold on;
end

%Applico l'algoritmo RANSAC
%Raccolgo tutte le coppie (x,y) di punti
puntiTotali = cat(2,cat(1,x_out,x),cat(1,y_out,y));

threshold = 30;
iterations = 50;
numPunti = length(puntiTotali);

%Voglio memorizzare il consenso associato a ciascun modello e anche i suoi
%parametri
consenso = zeros(1,iterations); 
parametri = zeros(iterations,2); %(m,q)

for i = 1:iterations
    index1 = randi([1 numPunti]);    
    punto1 = puntiTotali(index1,:); %Prelevo una coppia random (x,y)
    
    index2 = randi([1 numPunti]);
    while (index2 == index1)
        index2 = randi([1 numPunti]); %Voglio un punto diverso
    end
  
    punto2 = puntiTotali(index2,:); %Prelevo un'altra coppia random (x,y)
    
    %Costruisco il modello stimato (in questo quello di una retta, che ha due
    %parametri, il coefficiente angolare e il termine di traslazione (m,q))
    
    %(calcolo m e q poichè sono i parametri della retta e avere un modello
    %significa aver stimato i suoi parametri)
    m_stima = (punto2(2)-punto1(2)) / (punto2(1)-punto1(1));
    q_stima = -m_stima*punto1(1) + punto1(2);
   
    parametri(i,1) = m_stima;
    parametri(i,2) = q_stima;
    
    %Calcolo il consenso per il modello
    for k = 1:numPunti
        %Se la distanza tra il punto e la retta è minore del threshold
        %impostato, ho il consenso        
        if( abs((puntiTotali(k,2) - (parametri(i,1)*puntiTotali(k,1)+parametri(i,2)))) < threshold)
            consenso(i) = consenso(i) + 1;
        end    
    end 
end

%Estraggo il modello che ha ricevuto il consenso maggiore
for ind = 1:length(consenso)
    if(max(consenso) == consenso(ind))
        modelloStimato = cat(1,parametri(ind,1),parametri(ind,2));
    end
end

%Ricavo i punti inliers ("che hanno dato il consenso al modello più votato")
inliers = [];
outliers = [];
for n = 1:numPunti
    %Se la distanza tra il punto e la retta è minore del threshold
    %impostato, ho il consenso        
    if( abs( (puntiTotali(n,2) - (modelloStimato(1)*puntiTotali(n,1) + modelloStimato(2))) ) < threshold )
        inliers = [inliers; puntiTotali(n,:)];
    else
        outliers = [outliers; puntiTotali(n,:)];
    end    
end 


%Grafico i punti distinguendo attivamente tra inliers e outliers
figure;
for i = 1:length(inliers); j = 1:length(outliers); 
    plot(inliers(i,1),inliers(i,2),'g*');  
    plot(outliers(j,1),outliers(j,2),'r*');    
    hold on;
    
    %A questo punto basta fare un polyfit lineare solo sugli inlier
    %Usando il miglior metodo per una distrubuzione lineare (LS = minimi quadrati)
    coefficientiFit = polyfit(inliers(:,1),inliers(:,2),1);
    xFit = linspace(-100, 100, length(inliers));
    yFit = polyval(coefficientiFit, xFit);
    
    %Disegno la retta
    plot(xFit,yFit,'b');
end





    
