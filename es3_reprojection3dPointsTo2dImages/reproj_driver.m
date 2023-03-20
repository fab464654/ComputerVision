%Ex3: Analyse the data structure of the camera calibration toolbox and use
%the output of the calibration to project arbitrary 3D points to arbitrary
%image among the images used for calibration 

%In this script I'm using the provided code to  project 3D points to
%the images used for calibration, using the output of the calibration.

close all; clc; clear;

%Load calibration parameters and results using the "calibration toolbox"
cali = load(['imagesFromTutorial/calib_data.mat']);
camera = load(['imagesFromTutorial/Calib_Results.mat']);
KK = camera.KK; % KK = [f(1) alpha_c*f(1)  c(1);  0  f(2)  c(2);  0 0 1];
f = camera.fc;
c = camera.cc;
k = camera.kc;

%% Using image 2: 
%Load image 2 and its 3D points 
ImageIN = imread('imagesFromTutorial/Image2.tif');
X = cali.X_2;    %image 2

%Compute the internal/intrinsic parameters matrix (only one camera was used)
R = camera.Rc_2;   %image 2
T = camera.Tc_2;   %image 2

%To consider radial distortion correction:
om = camera.omc_2; %image 2
T = camera.Tc_2;   %image 2

%% Using image 10:
%Load image 10 and its 3D points 
ImageIN = imread('imagesFromTutorial/Image10.tif');
X = cali.X_10;      %image 10

%Compute the internal/intrinsic parameters matrix (only one camera was used)
R = camera.Rc_10;   %image 10
T = camera.Tc_10;   %image 10

%To consider radial distortion correction:
om = camera.omc_10; %image 10
T = camera.Tc_10;   %image 10

%% Here the plots are shown
close all;
%Show the loaded 3D points
figure; plot3(X(1,:),X(2,:), X(3,:), 'r*'); title("3D points");

%Compute the external parameters matrix
G = [R T; 0 0 0 1];

%Compute the full perspective matrix
ppm = KK * [1 0 0 0
            0 1 0 0
            0 0 1 0] * G;

%Project the 3D points to 2D pixels using the computed perspective matrix
[u,v] = proj(ppm,X');

%Plot the [u,v] pixels over the image
figure; imshow(ImageIN); hold on;
plot(u, v, 'b+');

%Project_points is a function available with the tool -> more accurate +
%removing distortion of the camera lens
[xp,dxpdom,dxpdT,dxpdf,dxpdc,dxpdk] = project_points(X,om,T,f,c,k);

%Plot the xp projected pixels over the image
figure; imshow(ImageIN); hold on;
plot(xp(1,:), xp(2,:), 'r+');


%Effetto speciale:
%traslo la scacchiera verso il basso di due quadrati:
coeff = 200;
XX_in = X;
XX_in(1,:) = (coeff*ones(1,length(X))) + X(1,:);

figure; plot3(XX_in(1,:),XX_in(2,:), XX_in(3,:), 'b+');

[xp_in,dxpdom,dxpdT,dxpdf,dxpdc,dxpdk] = project_points(XX_in,om,T,f,c,k);

figure; imshow(ImageIN); hold on;
plot(xp_in(1,:), xp_in(2,:), 'b+');






