function [x] = ifft2_d(f)
% FFT2_d performs ifftshift in each direction followed by and inverse 
% Fourier transform in the spatial entries 
%
% Thomas Sanchez - 2020

x = ifft2(ifftshift(ifftshift(f,1),2));
end

