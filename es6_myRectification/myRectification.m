
%Ex.6: Use the matlab calibration toolbox to calibrate a stereo set-up.
%Put the global ref to the left camera. Implement the image rectification
%and show that now epipolar lines are parallel and horizontal. 

%In this case the aim is to compute the new Perspective matrices using the
%theory behind and then check that the epipolar lines are parallel and
%horizontal

clear; close all; clc;

%Load the stereo calibration results (obtained with the Toolbox)
load('Calib_Results_stereo.mat');

%Read the images (10th from the chessboard)
imgLeft = imread('left01.jpg');
imgRight = imread('right01.jpg');


%We decide to put the global reference system on the left camera
Q_left = KK_left*eye(3); %R=Identity
q_left = [0; 0; 0;]; %because the ref. system is on this camera
P_left = horzcat(Q_left, q_left);

Q_right = KK_right*R;
q_right = KK_right*T;
P_right = horzcat(Q_right, q_right);

%At this point, to be coherent, I need to move the 3D points according to
%the chosen reference systems

%Import the 3D points: ss an example I select the 10th images
points3D = X_left_1; %world's ref. system

%X_left = 3D points in the left camera's ref. system
%points3D = 3D points in the world's ref. system
%Pose of the camera defined by Rc_ext = rodrigues(omc_ext) as explained in
%the toolbox and C=[0; 0; 0;]
Rc_ext = rodrigues(omc_left_1);
X_left = Rc_ext*(points3D - [0; 0; 0;]);
X_left = [X_left; ones(1,size(X_left,2))]; %homogeneous coord.

%Using the formula x = P*X , I extract the pixel coordinates
x_left = P_left*X_left; 
x_left = x_left(1:2,:)./x_left(3,:); %pixels in the left image

%Repeat the process for the right image
X_right = P_right*[points3D; ones(1,size(points3D,2))];
X_right = [X_right; ones(1,size(X_right,2))]; %homogeneous coord.

x_right = P_right*X_right; 
x_right = x_right(1:2,:)./x_right(3,:); %pixels in the right image

%Now, according to the theory I should build the new Rotation matrix
C_left = [0; 0; 0;]; %optical centre of the left camera
C_right = -inv(Q_right)*q_right;

%x-axis should be parallel to the baseline
r1 = (C_right-C_left)/norm(C_right-C_left);

%y-axis should be orthogonal to x and to an arbitrary versor (a suggestion
%is to use the old z-axis
z = [0 0 1]';
r2 = cross(z, r1)/norm(cross(z, r1));

%the third versor is just the cross product of r1xr2
r3 = cross(r1, r2)/norm(cross(r1, r2));

%So, the orientation R is given by putting the versors together
R = [r1'; r2'; r3'];

%Now we can build the new Perspective Matrices where the internal
%parameters and optical centre coord. are the same
Pn_left = KK_left * [R -R*C_left];
Pn_right = KK_left * [R -R*C_right];

%Having the new P matrices we can compute the transformation that takes us
%from the pixels of the old image to the pixels of the rectified one
%H_left and H_right are Homography matrices
H_left = Pn_left(:,1:3)*inv(Q_left);
H_right = Pn_right(:,1:3)*inv(Q_right);

%To compute the new points: x_new = H*x_old
x_left = [x_left; ones(1,size(x_left,2))]; %homogeneous coord.
x_right = [x_right; ones(1,size(x_right,2))]; %homogeneous coord.

xn_left = H_left * x_left;
xn_left = xn_left(1:2,:)./xn_left(3,:); %pixels in the right image

xn_right = H_right * x_right;
xn_right = xn_right(1:2,:)./xn_right(3,:); %pixels in the right image

%Call the image warping function
imgLeft_rect = imwarp(imgLeft, H_left);
imgRight_rect = imwarp(imgRight, H_right);

%Starting images as a reference
figure(1);  imshow(imgLeft); title('Starting left image');
figure(2); imshow(imgRight); title('Starting right image'); 

%Show the rectified images
figure(3); imshow(uint8(imgLeft_rect)); title('Rectified left image'); 
figure(4); imshow(uint8(imgRight_rect)); title('Rectified right image');


%Same code of the EpipolarLines exercize, now we see that they're parallel
%and horizontal as seen in the theory
i = 1;
while 1
    figure(3);
    %Collect points from the image
    m = [];
    [m(1),m(2)] = ginput(1);
    hold on;
    scatter(m(1),m(2), 'g', '+');
    text(m(1),m(2), strcat('.    ',num2str(i)));   
    
    %Compute the optical centre using the Perspective matrix for both
    %images
    C = [-inv(Pn_left(:,1:3))*Pn_left(:,4); 1];
    
    %Compute the epipole: e_prime := -Q_prime*inv(Q)*q + q_prime
    e_prime = -Pn_right(:,1:3)*inv(Pn_left(:,1:3))*Pn_left(:,4) + Pn_right(:,4);
   
    %Normalization
	e_prime = e_prime./norm(e_prime);
    
    %Compute the Fundamental matrix F := cross[e_prime]*Q_prime*inv(Q)
    F =  [   0         , -e_prime(3,1), e_prime(2,1) ;
          e_prime(3,1) ,   0          , -e_prime(1,1);
          -e_prime(2,1), e_prime(1,1) ,          0   ] *Pn_right(:,1:3)*inv(Pn_left(:,1:3));
    
    %Normalization  
    F = F./norm(F);

    %Recover the line equation
    m = [m 1]; %cart2hom
    coord = F * m.';
    width = size(imgRight_rect,2);
    x = 1:width;
    y = -coord(1)/coord(2)*x -coord(3)/coord(2);
    
    %Show the image     
    figure(4); hold on;    
    
    %Plot the corresponding epipolar line
    plot(x,y);
    
    i = i + 1;
end






