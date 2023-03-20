
% Following the tutorial I tried to verify that:
% "The output variable X_left_approx_1 is then an approximation of the original 
% 3D structure of the calibration grid stored in X_left_1." And they should
% match

% http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/example5.html

clear; clc; close all;

addpath('../../TOOLBOX_calib');

load 'Calib_Results_left.mat';
Rc_left_1 = Rc_1; %Assign Rc_1 for the left camera to the correct name
%(Rc_left_1 is the rotation matrix of the left camera)


load 'Calib_Results_stereo.mat';
%{
After running through the complete stereo calibration example, the image 
projections of the grid points on the right and left images are available 
in the variables x_left_1 and x_right_1. 
In order to triangulate those points in space, invoke stereo_triangulation.m
by inputting x_left_1,x_right_1, the extrinsic stereo parameters om and T 
and the left and right camera intrinsic parameters:
%}

%Compute the instructions provided
[Xc_1_left,Xc_1_right] = stereo_triangulation(x_left_1,x_right_1,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);

%{
The output variables Xc_1_left and Xc_1_right are the 3D coordinates of the
points in the left and right camera reference frames respectively (observe 
that Xc_1_left and Xc_1_right are related to each other through the rigid 
motion equation Xc_1_right = R * Xc_1_left + T ). 

It may be interesting to see that one can then re-compute the "intrinsic" 
geometry of the calibration grid from the triangulated structure Xc_1_left 
by undoing the left camera location encoded by Rc_left_1 and Tc_left_1:
%}

%rotation matrices are othogonal --> R' = inv(R)

%From the rigid motion equation: Xc_1_right = R * Xc_1_left + T

%I can write:                    inv(R) * ( Xc_1_right - T ) = Xc_1_left 

%So I'm computing:  X_left_approx_1 = inv(Rc_left_1) * (Xc_1_left - Tc_left_1)
X_left_approx_1 = Rc_left_1' * (Xc_1_left - repmat(Tc_left_1,[1 size(Xc_1_left,2)]));


%{
The output variable X_left_approx_1 is then an approximation of the original 
3D structure of the calibration grid stored in X_left_1. 
How well do they match?
%}

tollerance = 0.02;
ismembertol( X_left_approx_1 , X_left_1, tollerance)

