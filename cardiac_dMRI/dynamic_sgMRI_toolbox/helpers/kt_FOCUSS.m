function [X_FOCUSS]=kt_FOCUSS(k_original, mask)
% Runs the k-t FOCUSS algorithm on the data given a downsampling mask
% :params:
%   k_original: the fully sampled k_space volume to be reconstructed
%   mask: the current undersampling mask to construct the undersampled data
% :returns:
%   X_FOCUSS: the reconstructed image using k-t FOCUSS
%
% Thomas Sanchez - 2020


% function setting

A = @(x,mask)  (fft2_d(x)).*mask;
AT = @(x,mask) ifft2_d((x.*mask));

% parameter setting
factor = 0.5;
lambda_focuss = 0;
num_low_phase = 4;
Mouter = 2; % M outer
Minner = 40; %  M inner

f = k_original.*mask;

% low-frequency estimate
f_low = zeros(size(f));
mid = size(f,1)/2;
f_low(mid(1)-num_low_phase+1:mid(1)+num_low_phase,:,:) = f(mid(1)-num_low_phase+1:mid(1)+num_low_phase,:,:);

X_FOCUSS = KTFOCUSS(A, AT, f, f_low, mask, factor, lambda_focuss, Minner, Mouter);
