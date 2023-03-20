% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2030.441200679615804 ; 3023.811270792341475 ];

%-- Principal point:
cc = [ 2327.500000000000000 ; 1309.500000000000000 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.243240626615963 ; 0.060031902823856 ; 0.047797092460367 ; -0.025183895054798 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 49.153067280746981 ; 118.826866319269357 ];

%-- Principal point uncertainty:
cc_error = [ 0.000000000000000 ; 0.000000000000000 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.103231286976157 ; 0.198981980670184 ; 0.007710731788715 ; 0.018407853345480 ; 0.000000000000000 ];

%-- Image size:
nx = 4656;
ny = 2620;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 2;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 0;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.434982e+00 ; -1.826739e+00 ; -2.233168e-01 ];
Tc_1  = [ -4.645271e+01 ; -1.785588e+01 ; 9.149073e+01 ];
omc_error_1 = [ 4.508396e-03 ; 5.125765e-03 ; 5.206428e-02 ];
Tc_error_1  = [ 6.927948e-01 ; 2.987670e-01 ; 2.114710e+00 ];

%-- Image #2:
omc_2 = [ -1.267425e+00 ; -1.734007e+00 ; -2.307878e-01 ];
Tc_2  = [ -5.087379e+01 ; -1.900236e+01 ; 1.041291e+02 ];
omc_error_2 = [ 3.648596e-03 ; 5.861227e-03 ; 4.091705e-02 ];
Tc_error_2  = [ 8.901646e-01 ; 3.121682e-01 ; 2.262378e+00 ];

