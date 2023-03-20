
%Ex.8: implement the Fiore's method 

%The aim of this script is estimating the camera position given a set of 3D
%points and their projection to a image (2D pixels). Internal parameters are
%given (from a previous camera calibration).

clear; close all; clc;

%Load camera calibration data
load('imgInfo.mat')
K = imgInfo.K;                        %Internal parameters matrix
P = K*[imgInfo.R imgInfo.T];          %Perspective matrix

%Choose the number of points that Fiore's algorithm can use
numPointsFiore = 500;

%Load and compute point coordinates
p3D_all = imgInfo.punti3DImg(1:end,:)';             %load ALL 3D points
p3D_all_hom = [p3D_all; ones(1,size(p3D_all,2))]; 
p2D_all = imgInfo.punti2DImg(1:end,:)';             %load ALL 2D points
p2D_all_hom = [p2D_all; ones(1,size(p2D_all,2))]; 

%Points for Fiore (subset):
p2D = p2D_all(:,1:numPointsFiore);          %2D points
p2D_hom = p2D_all_hom(:,1:numPointsFiore);  %2D to homogeneous coordinates
p2D_norm = inv(K) * p2D_hom;                %2D to normalized coordinates
p3D = p3D_all(:,1:numPointsFiore);          %3D points
p3D_hom = p3D_all_hom(:,1:numPointsFiore);  %3D to homogeneous coordinates
         
%Read the image
img = imread('cav.jpg');

%Plot 3D points
figure; scatter3(p3D_all(1,:),p3D_all(2,:),p3D_all(3,:),5,'c'); axis equal; %3D points
title("Original (all) 3D points");

%Plot 2D points and projection from the 3D points and P matrix
figure; imshow(img); hold on;
plot(p2D(1,:), p2D(2,:),'r.','DisplayName','Original 2D points'); hold on;
pixelsFromP3D = P * p3D_hom;        %reproject 3D -> 2D
%"pixelsFromP3D" to cartesian coordinates
pixelsFromP3D = pixelsFromP3D ./ pixelsFromP3D(3,:); 
pixelsFromP3D(3,:) = [];
plot(pixelsFromP3D(1,:),pixelsFromP3D(2,:),'go','DisplayName','Reprojected 2D points'); %plot the points
title("2D points (subset) and their reprojection from 3D to 2D, using P");
legend;

%Exterior orientation problem, according to the theory:
%---------------------------------------------------------------------
% UDV' = svd(M)
% 
% [ξ·m] = D · ξ
% 
% To estimate ξ: ( (kron(V_r' * inv(K))*D ) * ξ = 0
% To find the absolute orientation: ξ(i)*inv(K)*m(i) = R*M(i) + t
%---------------------------------------------------------------------
n = size(p2D_norm,2);

%Create the D matrix
D = zeros(3*n,n);
for col=1:n    
    row = (col*3-2); %Ex: 1:3; 4:6; ...
    D(row:(row+2),col) = p2D_norm(:,col); %m (2D) points in column form   
end

%Compute kronecker product: kron(V_r' * inv(K)')
[~,~,V] = svd(p3D_hom); 
r = rank(p3D_hom);       %rank of M = p3D_hom
V_r = V(:, r+1:end);     %take only the (n-r) last columns of V

%Now compute: kron(V_r' * inv(K)) * D, solving for ξ using svd
clear V;
% [~,~,V] = svd(kron(V_r', inv(K))*D);
[~,~,V] = svd(kron(V_r', eye(3))*D);
csi = V(:,end); %ξ

%Compute vec(W)=D*ξ
vec_W = D*csi;

%Compute W from vec_W=[csi(1)*m(1) ... csi(n)*m(n)]
W = zeros(3, size(vec_W,1)/3);
currentCol=1;
for i=1:3:size(vec_W,1)
    W(:,currentCol) = vec_W(i:i+2);
    currentCol = currentCol + 1;
end

%Solving the Procustes Problem to compute "R" rotation matrix and "t"
%translation vector (as previously done in myICP_main.m)
%
%From the theory:
% 
%           [ 1   0      0          ]
%  R = V *  [ 0   1      0          ]  * U'
%           [ 0   0   det( V * U' ) ] 
%
X = p3D;
Y = W; 

X_bar = zeros(size(p3D));
Y_bar = zeros(size(W)); 

%Compute the CENTROID of X and Y
centroid_x = sum(X,2) ./ size(X,2);
centroid_y = sum(Y,2) ./ size(Y,2); 

%Move all the coordinates to the centroids ("bar" according to the theory)
for k=1:3
    X_bar(k,:) = X(k,:) - centroid_x(k);
    Y_bar(k,:) = Y(k,:) - centroid_y(k);
end
      
%Compute the scaling factor
s = norm(Y_bar) / norm(X_bar);

%Scale the centralized Y_bar points
Y_bar = Y_bar .* s;

%Compute the svd
[U,~,V] = svd( Y_bar * X_bar' );

%Rotation matrix "R"
R = U * diag([ 1, 1, det(V*U')]) * V';

%Translation vector "t" (scaled)
t = 1/s*centroid_y - R*centroid_x; 

%External parameters matrix
G = [R t];

%Compute the Full perspective matrix using the estimated External parameters matrix
P_fiore = K * G;
     
%Plot the projected points using Fiore's algorithm (use all the 3D points) 
fiorePoints2D = P_fiore * p3D_all_hom;        %reproject 3D -> 2D

%"pixelsFromP3D" to cartesian coordinates
fiorePoints2D = fiorePoints2D ./ fiorePoints2D(3,:);
fiorePoints2D(3,:) = [];

figure;
%starting image
imshow(img); hold on; 
%given 2D points
plot(p2D_all(1,:), p2D_all(2,:),'r.','DisplayName','Original 2D points'); hold on;
%2D points computed using Fiore's algorithm
plot(fiorePoints2D(1,:),fiorePoints2D(2,:),'go','DisplayName',"Reprojected 2D points using Fiore's algorithm"); 
title("2D points and their reprojection from 3D to 2D, using P-fiore");
legend;

 
     
