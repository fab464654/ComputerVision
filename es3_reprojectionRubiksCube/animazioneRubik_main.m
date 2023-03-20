
%In this script I'm using the provided code to  project 3D points to
%the images used for calibration, using the output of the calibration. In
%this case the Prof's code was adapted to see the result on the Rubik's
%cube (chosen calibration object).

close all; clear; clc;

%Load the calibration data and camera information obtained from the 2
%images of the Rubik's cube using the calibration toolbox
cali = load('calib_data.mat');
camera = load('Calib_Results.mat');

%Load the image
ImageIN = imread('imm1.jpg'); 
% ImageIN =imread('imm2.jpg'); 

%Select 3D points and camera parameters for the right image
X = cali.X_1;
om = camera.omc_1;
T = camera.Tc_1;
% X = cali.X_2;
% om = camera.omc_2;
% T = camera.Tc_2;
f = camera.fc; 
c = camera.cc; 
k = camera.kc; 

%Animazione! (Prof.'s code to show the animation adapted for the cube)
figure(1)
imshow(ImageIN);
hold on
hLine = line('XData',0, 'YData',0, 'Color','r', 'Marker','*', 'MarkerSize',6, 'LineWidth',5);
i=1;
punto=zeros(3,2);
punto(:,1)=X(:,1);
punto(:,2)=punto(:,1);
punto(2,2)=punto(2,2)+5;
verso=1; %speed of the point
nriga=1;
rigaoffset=0;

while true
    [xp_anim,dxpdom,dxpdT,dxpdf,dxpdc,dxpdk]=project_points(punto,om,T,f,c,k);
    set(hLine, 'XData',xp_anim(1,:), 'YData',xp_anim(2,:))
    drawnow
    %pause(0.005);
    if (i>=(cali.n_sq_x_2)*cali.dX_2)
        %If I reach the end of the cube I change row
        if (rigaoffset<3)
            if (rigaoffset==0)
                punto(2,2)=punto(2,1);
            end
            punto(1,1)=punto(1,1)+5;
            punto(1,2)=punto(1,1);
            rigaoffset=rigaoffset+1;
        else
            rigaoffset=0;
            nriga=nriga+1;
            if (nriga>cali.n_sq_x_2+1)
                punto(:,1)=X(:,1);
                punto(:,2)=punto(:,1);
                punto(2,2)=punto(2,2)+30;
                nriga=1;
            end
            i=1;
            verso=-verso;
        end
    else   
         %Move the point horizontally
        punto(2,1)=punto(2,1)-verso;
        punto(2,2)=punto(2,1)+5;
        i=i+abs(verso);
    end
    
    if ~ishandle(hLine), break; end
end





