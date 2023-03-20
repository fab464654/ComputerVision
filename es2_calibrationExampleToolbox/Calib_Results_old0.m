% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 657.643722567444797 ; 658.041099947672365 ];

%-- Principal point:
cc = [ 303.192371317683012 ; 242.555666734077136 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.256098140874780 ; 0.130887021172156 ; -0.000191178903128 ; 0.000038482156724 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.402418033300354 ; 0.430553522555592 ];

%-- Principal point uncertainty:
cc_error = [ 0.818578677325390 ; 0.748785526156568 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.003141991895008 ; 0.012507942864401 ; 0.000169366056932 ; 0.000167543022464 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.654720e+00 ; 1.651630e+00 ; -6.697971e-01 ];
Tc_1  = [ -5.928261e+02 ; -2.788601e+02 ; 2.844074e+03 ];
omc_error_1 = [ 9.548336e-04 ; 1.234537e-03 ; 1.577659e-03 ];
Tc_error_1  = [ 3.543139e+00 ; 3.266013e+00 ; 1.795000e+00 ];

%-- Image #2:
omc_2 = [ 1.848877e+00 ; 1.900269e+00 ; -3.969661e-01 ];
Tc_2  = [ -5.173553e+02 ; -5.309253e+02 ; 2.526174e+03 ];
omc_error_2 = [ 1.003370e-03 ; 1.226873e-03 ; 1.907770e-03 ];
Tc_error_2  = [ 3.163857e+00 ; 2.895410e+00 ; 1.764285e+00 ];

%-- Image #3:
omc_3 = [ 1.742277e+00 ; 2.077254e+00 ; -5.051086e-01 ];
Tc_3  = [ -4.182971e+02 ; -5.818270e+02 ; 2.585791e+03 ];
omc_error_3 = [ 9.182310e-04 ; 1.299949e-03 ; 1.972142e-03 ];
Tc_error_3  = [ 3.234189e+00 ; 2.962964e+00 ; 1.695892e+00 ];

%-- Image #4:
omc_4 = [ 1.827844e+00 ; 2.116467e+00 ; -1.102882e+00 ];
Tc_4  = [ -2.156149e+02 ; -5.159730e+02 ; 2.597800e+03 ];
omc_error_4 = [ 8.241364e-04 ; 1.346592e-03 ; 1.846788e-03 ];
Tc_error_4  = [ 3.259314e+00 ; 2.957332e+00 ; 1.366228e+00 ];

%-- Image #5:
omc_5 = [ 2.179823e+00 ; 6.124464e-01 ; 6.177374e-01 ];
Tc_5  = [ -5.550605e+02 ; -1.203606e+02 ; 1.598846e+03 ];
omc_error_5 = [ 1.276187e-03 ; 7.760938e-04 ; 1.503378e-03 ];
Tc_error_5  = [ 2.049190e+00 ; 1.863187e+00 ; 1.627222e+00 ];

%-- Image #6:
omc_6 = [ -1.701766e+00 ; -1.929498e+00 ; -7.917741e-01 ];
Tc_6  = [ -4.968138e+02 ; -2.653405e+02 ; 1.483829e+03 ];
omc_error_6 = [ 7.741044e-04 ; 1.253805e-03 ; 1.698239e-03 ];
Tc_error_6  = [ 1.860672e+00 ; 1.744717e+00 ; 1.428926e+00 ];

%-- Image #7:
omc_7 = [ 1.996394e+00 ; 1.931396e+00 ; 1.310790e+00 ];
Tc_7  = [ -2.769205e+02 ; -2.589841e+02 ; 1.468025e+03 ];
omc_error_7 = [ 1.482744e-03 ; 7.610818e-04 ; 1.780741e-03 ];
Tc_error_7  = [ 1.869610e+00 ; 1.705282e+00 ; 1.508437e+00 ];

%-- Image #8:
omc_8 = [ 1.961170e+00 ; 1.824198e+00 ; 1.326282e+00 ];
Tc_8  = [ -5.675979e+02 ; -3.450677e+02 ; 1.541068e+03 ];
omc_error_8 = [ 1.414830e-03 ; 7.761691e-04 ; 1.707587e-03 ];
Tc_error_8  = [ 2.044247e+00 ; 1.852767e+00 ; 1.699393e+00 ];

%-- Image #9:
omc_9 = [ -1.363901e+00 ; -1.980862e+00 ; 3.208860e-01 ];
Tc_9  = [ -7.026083e+00 ; -7.503111e+02 ; 2.429816e+03 ];
omc_error_9 = [ 9.645376e-04 ; 1.238753e-03 ; 1.596259e-03 ];
Tc_error_9  = [ 3.063384e+00 ; 2.779342e+00 ; 1.736715e+00 ];

%-- Image #10:
omc_10 = [ -1.513492e+00 ; -2.087101e+00 ; 1.880739e-01 ];
Tc_10  = [ -9.961734e+01 ; -1.001158e+03 ; 2.868351e+03 ];
omc_error_10 = [ 1.176193e-03 ; 1.408073e-03 ; 2.122499e-03 ];
Tc_error_10  = [ 3.681374e+00 ; 3.303827e+00 ; 2.305069e+00 ];

%-- Image #11:
omc_11 = [ -1.793139e+00 ; -2.065010e+00 ; -4.802063e-01 ];
Tc_11  = [ -5.042733e+02 ; -7.842938e+02 ; 2.350017e+03 ];
omc_error_11 = [ 1.054998e-03 ; 1.328754e-03 ; 2.283867e-03 ];
Tc_error_11  = [ 3.017936e+00 ; 2.829165e+00 ; 2.280152e+00 ];

%-- Image #12:
omc_12 = [ -1.839142e+00 ; -2.087535e+00 ; -5.158613e-01 ];
Tc_12  = [ -4.455811e+02 ; -5.905545e+02 ; 2.017320e+03 ];
omc_error_12 = [ 8.995580e-04 ; 1.277179e-03 ; 2.107401e-03 ];
Tc_error_12  = [ 2.570458e+00 ; 2.392218e+00 ; 1.906504e+00 ];

%-- Image #13:
omc_13 = [ -1.919022e+00 ; -2.116713e+00 ; -5.945150e-01 ];
Tc_13  = [ -4.428862e+02 ; -4.783445e+02 ; 1.816682e+03 ];
omc_error_13 = [ 8.392032e-04 ; 1.264257e-03 ; 2.072008e-03 ];
Tc_error_13  = [ 2.308133e+00 ; 2.141357e+00 ; 1.730357e+00 ];

%-- Image #14:
omc_14 = [ -1.954395e+00 ; -2.124760e+00 ; -5.847839e-01 ];
Tc_14  = [ -4.125110e+02 ; -4.569722e+02 ; 1.636969e+03 ];
omc_error_14 = [ 7.898118e-04 ; 1.238983e-03 ; 2.028443e-03 ];
Tc_error_14  = [ 2.082843e+00 ; 1.927689e+00 ; 1.553007e+00 ];

%-- Image #15:
omc_15 = [ -2.110704e+00 ; -2.253882e+00 ; -4.950597e-01 ];
Tc_15  = [ -6.643466e+02 ; -4.482040e+02 ; 1.584157e+03 ];
omc_error_15 = [ 9.113967e-04 ; 1.159851e-03 ; 2.210140e-03 ];
Tc_error_15  = [ 2.043127e+00 ; 1.911971e+00 ; 1.673484e+00 ];

%-- Image #16:
omc_16 = [ 1.886758e+00 ; 2.335939e+00 ; -1.729954e-01 ];
Tc_16  = [ -5.384667e+01 ; -5.675844e+02 ; 2.319400e+03 ];
omc_error_16 = [ 1.252546e-03 ; 1.323409e-03 ; 2.749145e-03 ];
Tc_error_16  = [ 2.905718e+00 ; 2.637226e+00 ; 1.981964e+00 ];

%-- Image #17:
omc_17 = [ -1.612964e+00 ; -1.953643e+00 ; -3.476711e-01 ];
Tc_17  = [ -4.512923e+02 ; -4.630206e+02 ; 1.634527e+03 ];
omc_error_17 = [ 7.804653e-04 ; 1.193989e-03 ; 1.682660e-03 ];
Tc_error_17  = [ 2.056059e+00 ; 1.912171e+00 ; 1.376813e+00 ];

%-- Image #18:
omc_18 = [ -1.341894e+00 ; -1.693366e+00 ; -2.975758e-01 ];
Tc_18  = [ -6.181499e+02 ; -5.257967e+02 ; 1.471945e+03 ];
omc_error_18 = [ 8.954029e-04 ; 1.160227e-03 ; 1.328849e-03 ];
Tc_error_18  = [ 1.869784e+00 ; 1.743562e+00 ; 1.337535e+00 ];

%-- Image #19:
omc_19 = [ -1.925896e+00 ; -1.838152e+00 ; -1.440606e+00 ];
Tc_19  = [ -3.556032e+02 ; -2.651522e+02 ; 1.114505e+03 ];
omc_error_19 = [ 7.704765e-04 ; 1.358494e-03 ; 1.721709e-03 ];
Tc_error_19  = [ 1.450844e+00 ; 1.330548e+00 ; 1.254251e+00 ];

%-- Image #20:
omc_20 = [ 1.895846e+00 ; 1.593082e+00 ; 1.471977e+00 ];
Tc_20  = [ -4.799451e+02 ; -2.933499e+02 ; 1.321380e+03 ];
omc_error_20 = [ 1.435138e-03 ; 7.937439e-04 ; 1.546477e-03 ];
Tc_error_20  = [ 1.771037e+00 ; 1.585852e+00 ; 1.517276e+00 ];

