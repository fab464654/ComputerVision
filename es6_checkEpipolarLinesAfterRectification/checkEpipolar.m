
%Calibration results obtained with the Toolbox
%http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/example5.html
%Basically here I'm checking that the drawn epipolar lines, after the image
%rectification process, are parallel and horizontal

clear; clc; close all;

%Load the results after the rectification using the Toolbox
load 'Calib_Results_stereo_rectified.mat';

%Assign the values 
cc_left_new = [cc_left_new; 1];   %to homogenous coordinates
cc_right_new = [cc_right_new; 1]; %to homogenous coordinates

%Computation of the new Perspective matrices
%(KK should be the same because it's the same camera)
Pn1 = KK_left_new * [R_new -R_new*cc_left_new]; 
Pn2 = KK_right_new * [R_new -R_new*cc_right_new];

Q = Pn1(:,1:3);
q = Pn1(:,4);

Q_prime = Pn2(:,1:3);
q_prime = Pn2(:,4);

%Load the previously rectified and saved images (using the Toolbox)
img1 = imread('left_rectified01.bmp');
img2 = imread('right_rectified01.bmp');

%Show the images
figure(1); imshow(img1);
figure(2); imshow(img2);
    
%Same code of the EpipolarLines exercize, now we see that they're parallel
%and horizontal as seen in the theory
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
    figure(2)    
    hold 'on';
    
    %Plot the corresponding epipolar line
    plot(x,y);
    
    i = i + 1;
end



