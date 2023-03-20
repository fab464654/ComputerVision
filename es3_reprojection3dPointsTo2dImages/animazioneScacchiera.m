close all
clear
clc

%Load the calibration data and camera information obtained from the previously
%executed tutorial of the calibrationToolbox
cali = load('imagesFromTutorial/calib_data.mat');
camera = load('imagesFromTutorial/Calib_Results.mat');

%Load the chessboard image (it works on every image with the proper params)
%ImageIN=imread('imagesFromTutorial/Image10.tif'); 
ImageIN = imread('imagesFromTutorial/Image5.tif'); 

%Select 3D points and camera parameters for the right image
X = cali.X_5;
om = camera.omc_5;
T = camera.Tc_5;
f = camera.fc; 
c = camera.cc; 
k = camera.kc; 

%Animazione! (Prof.'s code to show the animation)
figure(1)
imshow(ImageIN);
hold on
hLine = line('XData',0, 'YData',0, 'Color','r', 'Marker','*', 'MarkerSize',6, 'LineWidth',5);
i=1;
punto=zeros(3,2);
punto(:,1)=X(:,1);
punto(:,2)=punto(:,1);
punto(2,2)=punto(2,2)+50;
verso=10;
nriga=1;
rigaoffset=0;

while true
    [xp_anim,dxpdom,dxpdT,dxpdf,dxpdc,dxpdk]=project_points(punto,om,T,f,c,k);
    set(hLine, 'XData',xp_anim(1,:), 'YData',xp_anim(2,:))
    drawnow
    %pause(0.005);
    if (i>=(cali.n_sq_x_8+1)*cali.dX_8)
        %When the end of the chessboard is reached, changes row
        if (rigaoffset<10)
            if (rigaoffset==0)
                punto(2,2)=punto(2,1);
            end
            punto(1,1)=punto(1,1)+10;
            punto(1,2)=punto(1,1);
            rigaoffset=rigaoffset+1;
        else
            rigaoffset=0;
            nriga=nriga+1;
            if (nriga>cali.n_sq_x_8+1)
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
        punto(2,2)=punto(2,1)-50;
        i=i+abs(verso);
    end
    
    if ~ishandle(hLine), break; end
end





