%Ex.7: implement a matlab script that given two cloud of points it finds
%the rigid transformation that align them. 

%The aim of this script is finding the rigid transformation that aligns
%two given cloud of points. Iterative Closest Point algorithm was used.

clear; close all; clc;

%Set the sampling rate, in order to load less data than the maximum
srate = 3;

%Load the first cloud of 3D points
data = load('a4000001.cnn');
%Subsample data according to "srate"
s = size(data,1);
i = randperm(s);
i = i(1:round(s/srate));
data = data(i,:);

%Load the second cloud of 3D points
model = load('a4000007.cnn');
%Subsample model according to "srate"
s = size(model,1);
i = randperm(s);
i = i(1:round(s/srate));
model = model(i,:);

%Show "data" and "model" clouds of 3D points
figure;
plot3(model(:,1), model(:,2), model(:,3), '.b'); hold on;
plot3(data(:,1), data(:,2), data(:,3), '.r'); hold on;
grid on; axis equal; title("Starting clouds of 3D points");

%Compute the CENTROID of X and Y
centroid_x = sum(model) ./ size(model,1);
centroid_y = sum(data) ./ size(data,1);
%To check them on the plot
% plot3(centroid_x(1), centroid_x(2), centroid_x(3), '*g'); hold on;
% plot3(centroid_y(1), centroid_y(2), centroid_y(3), '*g'); hold on;
    
%Set the ICP threshold
threshold = 0.01;
error = inf;

%Apply the 3D rigid transformation T_total (4x4) that brings Y to X
%(model coordinates must be homogeneous)
T_total = eye(4);   %at first it's the identity
X = data;   
iteration = 0;
error_past = inf;   %at first it's infinity
%Model coordinates to homogeneous
model_hom = [model, ones(1,size(model,1))'];

figure(10);
while(error > threshold)
    iteration = iteration + 1;    
        
    %Move model coordinates according to T_total transformation matrix
    Y_to_X = T_total * model_hom';
    Y_to_X = Y_to_X';
    
    %Back to euclidean coordinates
    Y_to_X = Y_to_X(:,:) ./ Y_to_X(:,4);
    Y_to_X(:,4) = [];

    %Iterative Closest Point algorithm:
    closestPoints = zeros(size(model,1),3);     % 545x3 in this case
    euclideanDistance = zeros(1,size(model,1)); % 1x545 in this case

    for j = 1:size(Y_to_X,1)    % j = 1x545 in this case
        for k = 1:size(X,1)     % k = 1:545 in this case
            euclideanDistance(k) = norm(Y_to_X(j,:) - X(k,:)); %compute the norm
        end
        %find the closest point's index
        closestPointID = find(euclideanDistance == min(euclideanDistance));
        closestPointID = closestPointID(1); %keep only one point id
        closestPoints(j,:) = X(closestPointID,:);
    end

    X = closestPoints; %assign the closest points to X    

    %Absolute pose estimation is applied:
    %Compute the CENTROID of X and Y
    centroid_x = sum(X) ./ size(X,1);
    centroid_y = sum(Y_to_X) ./ size(Y_to_X,1); 
    
    %Move all the coordinates to the centroids ("bar" according to the theory)
    for k=1:3
        X_bar(:,k) = X(:,k) - centroid_x(k);
        Y_to_X_bar(:,k) = Y_to_X(:,k) - centroid_y(k);
    end
      
    
    %Solving the Procustes Problem to compute "R" rotation matrix
    %From the theory:
    % 
    %           [ 1   0      0          ]
    %  R = V *  [ 0   1      0          ]  * U'
    %           [ 0   0   det( V * U' ) ] 


    [U,D,V] = svd( X_bar' * Y_to_X_bar );

    %Rotation matrix "R"
    R = U * diag([ 1, 1, det(V*U')]) * V';

    %Translation vector "t"
    t = centroid_x' - R * centroid_y';
 
    %Transformation matrix from Y to X
    T = [   R,     t;
         0, 0, 0,  1];

    %At every iteration, update the "T_total" transformation matrix
    T_total = T * T_total;

    %Compute the error
    error_current = norm(Y_to_X(:,:) - X(:,:));
    error = abs(error_past - error_current);
    error_past = error_current;    
    
    %Show the resulting plot at every iteration
    figure(10); clf;
    plot3(X(:,1), X(:,2), X(:,3), '.b','DisplayName','X points'); hold on;
    plot3(Y_to_X(:,1), Y_to_X(:,2), Y_to_X(:,3), '.r','DisplayName','Y points'); hold on;
    grid on; axis equal;
    titleString = iteration + "° iteration;  error = " + error + " > threshold";
    title(titleString);
    %Show the two centroids
    plot3(centroid_y(1),centroid_y(2),centroid_y(3),'m*','MarkerSize',10,'DisplayName','Y centroids');
    plot3(centroid_x(1),centroid_x(2),centroid_x(3),'g*','MarkerSize',10,'DisplayName','X centroids');
    legend;
end

%Show the two aligned clouds of points
figure;
plot3(X(:,1), X(:,2), X(:,3), '.b','DisplayName','X points'); hold on;
plot3(Y_to_X(:,1), Y_to_X(:,2), Y_to_X(:,3), '.r','DisplayName','Y points'); hold on;
grid on; axis equal; title("Aligned clouds of 3D points");
%Show the two centroids
plot3(centroid_y(1),centroid_y(2),centroid_y(3),'m*','MarkerSize',10,'DisplayName','Y centroids');
plot3(centroid_x(1),centroid_x(2),centroid_x(3),'g*','MarkerSize',10,'DisplayName','X centroids');
legend;
   