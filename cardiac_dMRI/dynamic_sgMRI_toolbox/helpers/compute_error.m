function y = compute_error(O,R, metric) 
% COMPUTE_ERROR computes the error given a metric between an original image O
% and a reconstructed image R and returns the result
%
% Thomas Sanchez - 2020

O=single(O);
R=single(R); 

RMSE = @(X)(sqrt(1/numel(X)*sum(sum(sum(abs(X).*abs(X))))));

if strcmp(metric,'PSNR_abs')
    y     =    20*log10(max(abs(O(:)))/RMSE(abs(R(:)) - abs(O(:))));

elseif strcmp(metric,'PSNR')
    y     =    20*log10(max(abs(O(:)))/RMSE(R - O));

elseif strcmp(metric,'SSIM')
    Ru=(abs(R)/max(abs(R(:))));
    Ou=(abs(O)/max(abs(O(:))));
    y     =   ssim(double(Ru),double(Ou));

elseif strcmp(metric,'RMSE')
    y     =  - RMSE(R-O);        
else
    error('Unknown metric')
end


end