% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 657.462413707501582 ; 657.946120796549849 ];

%-- Principal point:
cc = [ 303.137197801650473 ; 242.569961386837093 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.254025340413923 ; 0.121427133171044 ; -0.000208717489674 ; 0.000019582481727 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.318172586741717 ; 0.340445865045616 ];

%-- Principal point uncertainty:
cc_error = [ 0.646787859971176 ; 0.592154685469051 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.002482614403104 ; 0.009863174885677 ; 0.000133833852743 ; 0.000132167108853 ; 0.000000000000000 ];

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
omc_1 = [ 1.654928e+00 ; 1.651990e+00 ; -6.694039e-01 ];
Tc_1  = [ -5.925766e+02 ; -2.795933e+02 ; 2.843821e+03 ];
omc_error_1 = [ 7.555908e-04 ; 9.761484e-04 ; 1.248136e-03 ];
Tc_error_1  = [ 2.799738e+00 ; 2.582880e+00 ; 1.419475e+00 ];

%-- Image #2:
omc_2 = [ 1.849122e+00 ; 1.900688e+00 ; -3.966382e-01 ];
Tc_2  = [ -5.170373e+02 ; -5.315872e+02 ; 2.525509e+03 ];
omc_error_2 = [ 7.936737e-04 ; 9.698948e-04 ; 1.509021e-03 ];
Tc_error_2  = [ 2.499590e+00 ; 2.289194e+00 ; 1.395023e+00 ];

%-- Image #3:
omc_3 = [ 1.742596e+00 ; 2.077768e+00 ; -5.049744e-01 ];
Tc_3  = [ -4.177413e+02 ; -5.823758e+02 ; 2.585253e+03 ];
omc_error_3 = [ 7.264609e-04 ; 1.027708e-03 ; 1.560148e-03 ];
Tc_error_3  = [ 2.555250e+00 ; 2.342701e+00 ; 1.340957e+00 ];

%-- Image #4:
omc_4 = [ 1.828128e+00 ; 2.116859e+00 ; -1.103001e+00 ];
Tc_4  = [ -2.151234e+02 ; -5.165302e+02 ; 2.597124e+03 ];
omc_error_4 = [ 6.520720e-04 ; 1.064753e-03 ; 1.460822e-03 ];
Tc_error_4  = [ 2.575274e+00 ; 2.338130e+00 ; 1.080201e+00 ];

%-- Image #5:
omc_5 = [ 2.180159e+00 ; 6.123333e-01 ; 6.170933e-01 ];
Tc_5  = [ -5.549798e+02 ; -1.201480e+02 ; 1.598854e+03 ];
omc_error_5 = [ 1.009049e-03 ; 6.134620e-04 ; 1.188767e-03 ];
Tc_error_5  = [ 1.619437e+00 ; 1.473482e+00 ; 1.286450e+00 ];

%-- Image #6:
omc_6 = [ -1.701346e+00 ; -1.929109e+00 ; -7.917751e-01 ];
Tc_6  = [ -4.965044e+02 ; -2.656673e+02 ; 1.482543e+03 ];
omc_error_6 = [ 6.120162e-04 ; 9.908509e-04 ; 1.342029e-03 ];
Tc_error_6  = [ 1.469241e+00 ; 1.378748e+00 ; 1.128793e+00 ];

%-- Image #7:
omc_7 = [ 1.996583e+00 ; 1.931515e+00 ; 1.311023e+00 ];
Tc_7  = [ -2.767689e+02 ; -2.592161e+02 ; 1.467209e+03 ];
omc_error_7 = [ 1.171820e-03 ; 6.019909e-04 ; 1.408302e-03 ];
Tc_error_7  = [ 1.476799e+00 ; 1.347973e+00 ; 1.192521e+00 ];

%-- Image #8:
omc_8 = [ 1.961143e+00 ; 1.824220e+00 ; 1.326779e+00 ];
Tc_8  = [ -5.672914e+02 ; -3.452620e+02 ; 1.540003e+03 ];
omc_error_8 = [ 1.118699e-03 ; 6.142156e-04 ; 1.350864e-03 ];
Tc_error_8  = [ 1.614279e+00 ; 1.464265e+00 ; 1.343281e+00 ];

%-- Image #9:
omc_9 = [ -1.363619e+00 ; -1.980445e+00 ; 3.210451e-01 ];
Tc_9  = [ -6.514539e+00 ; -7.505369e+02 ; 2.428139e+03 ];
omc_error_9 = [ 7.626691e-04 ; 9.794004e-04 ; 1.262134e-03 ];
Tc_error_9  = [ 2.419369e+00 ; 2.196573e+00 ; 1.372659e+00 ];

%-- Image #10:
omc_10 = [ -1.513021e+00 ; -2.086648e+00 ; 1.888875e-01 ];
Tc_10  = [ -9.882017e+01 ; -1.001612e+03 ; 2.866927e+03 ];
omc_error_10 = [ 9.303163e-04 ; 1.113451e-03 ; 1.677677e-03 ];
Tc_error_10  = [ 2.908001e+00 ; 2.611508e+00 ; 1.821947e+00 ];

%-- Image #11:
omc_11 = [ -1.793031e+00 ; -2.064967e+00 ; -4.800587e-01 ];
Tc_11  = [ -5.037490e+02 ; -7.849438e+02 ; 2.348814e+03 ];
omc_error_11 = [ 8.348462e-04 ; 1.051025e-03 ; 1.806749e-03 ];
Tc_error_11  = [ 2.383918e+00 ; 2.236509e+00 ; 1.802780e+00 ];

%-- Image #12:
omc_12 = [ -1.838801e+00 ; -2.087240e+00 ; -5.158081e-01 ];
Tc_12  = [ -4.451665e+02 ; -5.910481e+02 ; 2.016110e+03 ];
omc_error_12 = [ 7.113465e-04 ; 1.009563e-03 ; 1.665790e-03 ];
Tc_error_12  = [ 2.030313e+00 ; 1.890995e+00 ; 1.506957e+00 ];

%-- Image #13:
omc_13 = [ -1.918715e+00 ; -2.116506e+00 ; -5.945314e-01 ];
Tc_13  = [ -4.425127e+02 ; -4.788240e+02 ; 1.815645e+03 ];
omc_error_13 = [ 6.635279e-04 ; 9.992346e-04 ; 1.637680e-03 ];
Tc_error_13  = [ 1.823207e+00 ; 1.692737e+00 ; 1.367703e+00 ];

%-- Image #14:
omc_14 = [ -1.954108e+00 ; -2.124529e+00 ; -5.849565e-01 ];
Tc_14  = [ -4.121783e+02 ; -4.573728e+02 ; 1.635811e+03 ];
omc_error_14 = [ 6.244782e-04 ; 9.794166e-04 ; 1.603271e-03 ];
Tc_error_14  = [ 1.644999e+00 ; 1.523563e+00 ; 1.227364e+00 ];

%-- Image #15:
omc_15 = [ -2.110566e+00 ; -2.253735e+00 ; -4.956820e-01 ];
Tc_15  = [ -6.640050e+02 ; -4.485721e+02 ; 1.582955e+03 ];
omc_error_15 = [ 7.211665e-04 ; 9.179003e-04 ; 1.748369e-03 ];
Tc_error_15  = [ 1.613066e+00 ; 1.511069e+00 ; 1.323464e+00 ];

%-- Image #16:
omc_16 = [ 1.887030e+00 ; 2.336243e+00 ; -1.738221e-01 ];
Tc_16  = [ -5.336690e+01 ; -5.680017e+02 ; 2.318916e+03 ];
omc_error_16 = [ 9.918786e-04 ; 1.047928e-03 ; 2.180040e-03 ];
Tc_error_16  = [ 2.296008e+00 ; 2.085308e+00 ; 1.567531e+00 ];

%-- Image #17:
omc_17 = [ -1.612582e+00 ; -1.953294e+00 ; -3.477439e-01 ];
Tc_17  = [ -4.509196e+02 ; -4.633290e+02 ; 1.633222e+03 ];
omc_error_17 = [ 6.169373e-04 ; 9.435409e-04 ; 1.330041e-03 ];
Tc_error_17  = [ 1.623575e+00 ; 1.511100e+00 ; 1.087640e+00 ];

%-- Image #18:
omc_18 = [ -1.341591e+00 ; -1.692586e+00 ; -2.972901e-01 ];
Tc_18  = [ -6.181320e+02 ; -5.261130e+02 ; 1.470118e+03 ];
omc_error_18 = [ 7.083066e-04 ; 9.165073e-04 ; 1.050289e-03 ];
Tc_error_18  = [ 1.475928e+00 ; 1.377294e+00 ; 1.056985e+00 ];

%-- Image #19:
omc_19 = [ -1.925664e+00 ; -1.837984e+00 ; -1.440615e+00 ];
Tc_19  = [ -3.554112e+02 ; -2.653367e+02 ; 1.113631e+03 ];
omc_error_19 = [ 6.093463e-04 ; 1.074275e-03 ; 1.361119e-03 ];
Tc_error_19  = [ 1.145733e+00 ; 1.051409e+00 ; 9.912435e-01 ];

%-- Image #20:
omc_20 = [ 1.895969e+00 ; 1.593180e+00 ; 1.471969e+00 ];
Tc_20  = [ -4.798647e+02 ; -2.933636e+02 ; 1.321253e+03 ];
omc_error_20 = [ 1.134669e-03 ; 6.279712e-04 ; 1.223544e-03 ];
Tc_error_20  = [ 1.399231e+00 ; 1.254009e+00 ; 1.199873e+00 ];

