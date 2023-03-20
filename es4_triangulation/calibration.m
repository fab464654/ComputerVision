


clear all;
close all;
clc;

%Load the image
%img = imread('imm1.jpg');
img = imread('imm2.jpg');


%Calibration object (known)

Mi = [0,0,5.5,1;
      0,0,0,1;
      5.5,0,0,1;
      5.5,5.5,0,1;
      5.5,5.5,5.5,1;
      5.5,0,5.5,1];

%{   
Mi = [0,0,5.5,1;
      5.5,0,5.5,1;
      5.5,5.5,5.5,1;
      0,5.5,5.5,1;
      5.5,0,0,1;
      5.5,5.5,0,1];
   
%}
      
%Show the image
fig1 = figure(1)
imshow(img);
hold on;


%Collect points from the image
%(the user needs to do it)
xc = [];
yc = [];
calib_i = 0;
while calib_i < 6 %need 6 points
    [clickX,clickY] = ginput(1);
    xc = [xc; clickX];
    yc = [yc; clickY];
    scatter(clickX, clickY, 'g', '+');
    text(clickX, clickY, strcat('.    ',num2str(calib_i+1)));
    calib_i = calib_i + 1;
    
end

%Gli ones sono per avere in coordinate non omogenee
mi = [xc, yc, ones(6,1)]; %6 points, so 6 ones for each pixel coord.


A = []; %build the matrix A = trasp(Mi)*kron*[mi]<-matrix of cross product
%Calibration
for i = 1:6
    
    a = mi(i,:).';     
    %Compute the matrix of cross product (scew symmetric)
    ax = [   0   , -a(3,1), a(2,1) ;
          a(3,1) ,   0    , -a(1,1);
          -a(2,1), a(1,1) ,   0   ]; %ax should be [mi]
    
    %Mi is M transposed (è già in forma 1x4)
    KRO = kron(ax, Mi(i,:));
    
    %Matrix of known terms (3D coord + Pixels)
    A = [A; KRO(1,:); KRO(2,:)];

end

%Singular value decomposition to find the solution of Ax=0
[U, S, V] = svd(A, 'econ');

%Vectorization, only the last column of the V matrix
vecP = V(:, size(A,2));

%Having computed the vector, we need to rearrange it in a matrix form
P = [vecP(1,1), vecP(2,1), vecP(3,1), vecP(4,1);
     vecP(5,1), vecP(6,1), vecP(7,1), vecP(8,1);
     vecP(9,1), vecP(10,1), vecP(11,1), vecP(12,1);
     ] %3x4
 
%Ora abbiamo la Projection Matrix

%Proietto i punti sull'immagine per effettuare una verifica:
m_reproj = [];
for j = 1:6
    %mi=P*Mi
    mcurrent = P*(Mi(j,:).'); %ATTENZIONE: .' = TRASPOSTA    
    %Pixel in coordinate Euclidee
    m_reproj = [m_reproj; mcurrent.'/mcurrent(3,1)]; %divide by the 3 component
end

hold on;

for k = 1:6
   
    scatter(m_reproj(k,1),m_reproj(k,2),'r');
    scatter(xc(k,1),yc(k,1),'g','+');
    text((m_reproj(k,1)),(m_reproj(k,2)),strcat('.       ',num2str(k)));
    
end
 

% Change the name of PPM here
%save('Calib_direct_forImm1.mat', 'P');
save('Calib_direct_forImm2.mat', 'P');


