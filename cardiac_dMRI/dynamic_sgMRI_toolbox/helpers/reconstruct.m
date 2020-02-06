function [ x_recon ] = reconstruct(k_original, mask, algo )
%RECONSTRUCT Undersamples the image space data in Fourier domain with the mask
%               provided and then performs TV reconstruction.
%   :params:
%       k_original: the Fourier space data of the slice to be reconstructed
%       mask: the undersampling mask to be tested.
%   :returns:
%       x_recon: the algo-reconstructed data for the undersampled image using
%       the given mask.
%
% Thomas Sanchez - 2020

    if strcmp(algo, 'ktf') % k-t FOCUSS
        x_recon = kt_FOCUSS(k_original, mask);
        
    elseif strcmp(algo,'ist') % Iterative soft-thresholding
        
        y = k_original.*mask;
        x_recon = CSL1SoftThresh(y);
 
    elseif strcmp(algo,'aloha') % ALOHA s
        ddata       = k_original.*mask;
        aloha_param = struct('dname','cardiac4ch','data',ddata,'mask',mask,...
                 'm',5, 'n',5,'mu',10,'muiter_set', ...
                 [50,50],'tolE',[1e-1 1e-2],'rofft',1);        
         pro     = aloha_kt(aloha_param);
         x_recon   = ifft_kt(pro.recon);
    else
        error('Unknown reconstruction algorithm')
    end

end

