function [f] = fft2_d(x)
% FFT2_d performs Fourier transform in the spatial entries followed by
% fftshift in each direction to center the low-frequencies.
%
% Thomas Sanchez - 2020

f = fftshift(fftshift(fft2(x),1),2);
end

