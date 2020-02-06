function [ x_recon ] = reconstruct( x_original, mask )
%RECONSTRUCT Undersamples the image space data in Fourier domain with the mask
%               provided and then performs TV reconstruction.
%   :params:
%       x_original: the image space data of the slice to be reconstructed
%       mask: the undersampling mask to be tested.
%   :returns:
%       x_recon: the TV-reconstructed data for the undersampled image using
%       mask.
%
% Thomas Sanchez - 2020

    % Parameters
    opts        = [];
    opts.maxiter = 1000;
    muf = 1e-5; 
    opts.Verbose  = 0;
    opts.MaxIntIter = 1;
    opts.TolVar = 1e-5;
    opts.typemin = 'tv';
    
    delta = 0; 
    [nx, ny]=size(x_original);
    N=nx*ny;
    
    % Measurement operators
    ind = find(mask);
    measurement_forward  = @(x) fft2fwd(reshape(x,[nx,ny]),ind);
    measurement_backward = @(x) reshape(fft2adj(x,ind,nx,ny),[N,1]);
    
    b  = measurement_forward(x_original);
    A=measurement_forward;
    At=measurement_backward;

    % Reconstruction
    [x_NESTA_complex,~,~,~,~] =NESTA(A,At,b,muf,delta,opts);
    x_recon=reshape(x_NESTA_complex,[nx,ny]);

end

