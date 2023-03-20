
%Ex.5: Take the two views from the previous excercise and draw epipolar 
%lines on the right image of arbitrary points from the left image.

clear; close all; clc;

%Load the calibration matrices for the 2 images
P1 = load('Calib_direct_forImm1.mat').P;
P2 = load('Calib_direct_forImm2.mat').P;
%Load the images
img1 = imread('imm1.jpg');
img2 = imread('imm2.jpg');

% %Check the results using Prof.'s images
% P1 = load('IMG_0011.JPG.ppm'); 
% P2 = load('IMG_0012.JPG.ppm');
% %Load Prof.'s images
% img1 = imread('IMG_0011.jpg'); 
% img2 = imread('IMG_0012.jpg'); 

%Extract Q, q, Q_prime and q_prime
Q = P1(1:3,1:3);
q = P1(1:3,4);
Q_prime = P2(1:3,1:3);
q_prime = P2(1:3,4);

%Show the images
figure(1); imshow(img1);
figure(2); imshow(img2);
    
%Compute and show the epipolar lines
i = 1;
while 1

    figure(1);
    %Collect points from the image
    m = [];
    [m(1),m(2)] = ginput(1);
    hold on;
    scatter(m(1),m(2), 'g', '+');
    text(m(1),m(2), strcat('.    ',num2str(i)));   
    
    %Compute the optical centre using the Perspective matrix for both
    %images
    C = [-inv(Q)*q; 1];
    
    %Compute the epipole: e_prime := -Q_prime*inv(Q)*q + q_prime
    e_prime = -Q_prime*inv(Q)*q + q_prime;
    %Same result given by:
    %P_prime = horzcat(Q_prime, q_prime);
    %e_prime = P_prime*C
    
    %Normalization
	e_prime = e_prime./norm(e_prime);
    
    %Compute the Fundamental matrix F := cross[e_prime]*Q_prime*inv(Q)
    F =  [   0         , -e_prime(3,1), e_prime(2,1) ;
          e_prime(3,1) ,   0          , -e_prime(1,1);
          -e_prime(2,1), e_prime(1,1) ,          0   ] *Q_prime*inv(Q);
    
    %Normalization  
    F = F./norm(F);

    %Recover the line equation
    m = [m 1]; %cartesian to homogeneous coordinates
    coord = F * m.';
    width = size(img2,2);
    x = 1:width;
    y = -coord(1)/coord(2)*x -coord(3)/coord(2);
    
    %Show the image
    figure(2); hold on;
    
    %Plot the corresponding epipolar line
    plot(x,y);
    
    i = i + 1;
end



