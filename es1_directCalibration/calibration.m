%Ex1: Implement the direct method for camera calibration using an arbitrary
%calibration object 

clear; close all; clc;

%Load the image with the calibration object (Rubik's cube)
img = imread('image1.jpg');

%Calibration object's 3D points coordinates (order as shown in the order.jpg file) 
Mi = [0,   0,   5.5,  1;
      0,   0,   0,    1;
      5.5, 0,   0,    1;
      5.5, 5.5, 0,    1;
      5.5, 5.5, 5.5,  1;
      5.5, 0,   5.5,  1];

%Show the image
figure; imshow(img);
hold on;

%Ask the user to click on 6 points in the right order
xc = [];
yc = [];

for j = 1:6
    [clickX,clickY] = ginput(1); %left click
    xc = [xc; clickX];
    yc = [yc; clickY];
    scatter(clickX, clickY, 'g', '+'); %draw the points
    text(clickX, clickY, strcat('.    ',num2str(j))); %draw the number    
end

%Put together the collected coordinates of the 6 points in homogenous
%coordinates
mi = [xc, yc, ones(6,1)]; %these are pixels


%Build the matrix A = transp(Mi)*kron*[mi]x <-matrix of cross product
A = []; 

for i = 1:6    
    a = mi(i,:).';    
    
    %Compute the matrix of cross product (scew symmetric)
    ax = [   0   , -a(3,1), a(2,1) ;
          a(3,1) ,   0    , -a(1,1);
          -a(2,1), a(1,1) ,   0   ]; %ax is the same as [mi]x
    
    %Mi is transp(Mi) (already 1x4)
    KRO = kron(ax, Mi(i,:));
    
    %Matrix of known terms (3D coord + Pixels)
    A = [A; KRO(1,:); KRO(2,:)];
end

%Singular Value Decomposition to find the solution of Ax=0
[U, S, V] = svd(A, 'econ');

%Vectorization, only the last column of the V matrix
vecP = V(:, size(A,2));

%Having computed the vector, we need to rearrange it in a matrix form
P = [vecP(1,1), vecP(2,1),  vecP(3,1),  vecP(4,1);
     vecP(5,1), vecP(6,1),  vecP(7,1),  vecP(8,1);
     vecP(9,1), vecP(10,1), vecP(11,1), vecP(12,1);
     ]; %3x4
 
%Now we have the Perspective Matrix, we can reproject the 3D points on the
%image to see if they correspond (mi=P*Mi)

m_reproj = [];
for j = 1:6   
    mcurrent = P*(Mi(j,:).');
    %Divide by the 3 component to get Euclidean coordinates
    m_reproj = [m_reproj; mcurrent.'/mcurrent(3,1)]; 
end

hold on;

for k = 1:6
    %Draw the points on the image
    scatter(m_reproj(k,1),m_reproj(k,2),'r');
    scatter(xc(k,1),yc(k,1),'g','+');
    text((m_reproj(k,1)),(m_reproj(k,2)),strcat('.       ',num2str(k)));
end
 

%Save the Perspective Matrix
% save('Calib_direct_matrix.mat', 'P');


