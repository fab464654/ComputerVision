%Ex4: Take two views from your calibrated set-up, estimate the 3D coordinates
%of two points (ask the user to click on the conjugate pixels), and measure
%the euclidean distance between these points (if the calibration object is
%fixed the global reference system is coherent for the two views). 

clear; close all; clc;

%Load the camera parameters of the first image
load('Calib_direct_forImm1.mat')
P_imm1 = P;

%Load the camera parameters of the second image
load('Calib_direct_forImm2.mat')
P_imm2 = P;

I1 = imread('imm1.jpg');
I2 = imread('imm2.jpg');

%Show the first image
figure; imshow(I1); hold on;

%Ask the user to collect 2 points from the first image
x1 = [];
y1 = [];
for i = 1:2 
    [clickX,clickY] = ginput(1);
    x1 = [x1; clickX];
    y1 = [y1; clickY];
    scatter(clickX, clickY, 'g', '+');
    text(clickX, clickY, strcat('.    ',num2str(i)));
end

%Draw the line between the points
hold on; plot(x1,y1,'g');

%Repeat the process for the second image
figure; imshow(I2); hold on;

%Ask the user to collect the same 2 points but in the second image
x2 = [];
y2 = [];
for i = 1:2 
    [clickX,clickY] = ginput(1);
    x2 = [x2; clickX];
    y2 = [y2; clickY];
    scatter(clickX, clickY, 'g', '+');
    text(clickX, clickY, strcat('.    ',num2str(i)));
end

%Draw the line between the points
hold on; plot(x2,y2,'g');


%To estimate the 3d point we have to draw the optical rays of both the
%conjugate points and find the intersection

%System to solve: (p1-up3).' 
%                 (p2-vp3).'     M(4x1) = 0(4x1)
%                 (p1'-up3').' 
%                 (p2'-vp3').'
%
%                   A              x   = 0

%Normalization
P_imm1 = P_imm1(:,:)./norm(P_imm1(3,1:3));
P_imm2 = P_imm2(:,:)./norm(P_imm2(3,1:3));

A_1 = [(P_imm1(1,:)-x1(1)*P_imm1(3,:));   %x1(1) = u
       (P_imm1(2,:)-y1(1)*P_imm1(3,:));   %y1(1) = v
       (P_imm2(1,:)-x2(1)*P_imm2(3,:));   %x2(1) = u'
       (P_imm2(2,:)-y2(1)*P_imm2(3,:))];  %y2(1) = v'
 
%Singular value decomposition to find the solution of Ax=0
[~, ~, V] = svd(A_1, 'econ');

%Vectorization, only the last column of the V matrix
M_1 = V(:, size(A_1,2));
M_1 = M_1(1:3)./M_1(4); %back to inhomogeneous coordinates
 
A_2 = [(P_imm1(1,:)-x1(2)*P_imm1(3,:));   %x1(2) = u (for the 2 point)
       (P_imm1(2,:)-y1(2)*P_imm1(3,:));   %y1(2) = v (for the 2 point)
       (P_imm2(1,:)-x2(2)*P_imm2(3,:));   %x2(2) = u' (for the 2 point)
       (P_imm2(2,:)-y2(2)*P_imm2(3,:))];  %y2(2) = v' (for the 2 point)

%Singular value decomposition to find the solution of Ax=0
[~, ~, V] = svd(A_2, 'econ');

%Vectorization, only the last column of the V matrix
M_2 = V(:, size(A_2,2));
M_2 = M_2(1:3)./M_2(4); %back to inhomogeneous coordinates


myDistance = sqrt(sum( (M_1(:,1) - M_2(:,1)) .^2));
fprintf("The computed euclidean distance is: %f", myDistance);

%{
Same result for the Euclidean distance
aux = 0;
for i = 1:3    
    aux = aux + (M_1(i) - M_2(i))^2;    
end
distance = sqrt(aux)
%}

%I also try to compute the distance using the file library "intersect_base"
%(as a check)
mleft = [x1(1) x1(2); y1(1) y1(2)];
mright = [x2(1) x2(2); y2(1) y2(2)];
Ptot(:,:,1) = P_imm1;
Ptot(:,:,2) = P_imm2;

m(:,:,1) = mleft;
m(:,:,2) = mright;
M = intersect_base(Ptot,m);
distanceLibrary = sqrt(sum( (M(:,1) - M(:,2)) .^2));
fprintf("\nDistance computed by the library: %f\n", distanceLibrary);

%Plot the points over the image
close all; imshow(I2); hold on;
plot(x2(1,:),y2(1,:),'r*'); hold on;
plot(x2(2,:),y2(2,:),'r*');

%Draw the line between the 2 points
hold on; plot(x2,y2,'g');

%Print the distance [cm] between the 2 points
text(x2(1,:),y2(1,:), strcat('     distance:  ',num2str(myDistance),' cm'),'Color','g','FontSize', 20);

