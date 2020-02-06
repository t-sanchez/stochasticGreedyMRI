function x = CSL1SoftThresh(y)
% CSL1SoftThresh implements a soft-thresholding iterative meethod for
% solving a CS problem with l1 regularization. This code is inspired by the
% code written by Ricardo Otazo in 2009 for the article.
% Otazo R, Kim D, Axel L, Sodickson DK. "Combination of compressed sensing
% and parallel imaging for highly accelerated first-pass cardiac perfusion 
% MRI". Magn Reson Med. 2010; 64(3):767-76.
% and available at 
% https://cai2r.net/resources/software/k-t-sparse-sense-matlab-code
% It takes as input an undersampled Fourier image y and does
% soft-thresholding in the x-f domain. 
% 
% Thomas Sanchez - 2020

%Parameters
lambda = 0.046415888336128; % regularisation parameter
dec =  0.016681005372001; % the amount lambda is decreased at each iteration.
nite=100; % the original undersampled k-space reconstruction.
tol=5e-4; %  the total number of iterations
display=0; % the error tolerance

%Initialize
x0 = ifft2_d(y);
x=x0;
ite=0;

if  display
    fprintf('\n Iterative soft-thresholding algorithm \n')
    fprintf('\n min norm(W*x,1) s.t. F*x=y \n')
    fprintf('\n ite   lambda     norm(W*x,1)    diff \n')
    fprintf(' -------------------------------------------\n');
end 

% Iterate
while(1)
    x0 = x; %initial guess
    X = fft(x0, [],3); %sparsifying the initial guess in fourier domain
    lambda = lambda*(1-ite*dec); %decreasing lambda 
    X = SoftThresh(X,lambda); 
    x = ifft(X, [],3); % Inverse temporal FT
    Y = fft2_d(x); % Spatial FT
    Y = Y.*(y==0) + y; % y is the reference Fourier domain 
    x = ifft2_d(Y);
    ite = ite + 1;
    % print some numbers for debug purposes	
    if display
        fprintf(' %d   %f   %f  %f\n', ite, lambda,norm(X(:),1),norm(x(:)-x0(:))/norm(x0(:)));
    end
    % stopping criteria 
	if (ite > nite-1) || (norm(x(:)-x0(:))<tol*norm(x0(:))), break;end
    
end
return;

function y=SoftThresh(x,p)
y=(abs(x)-p).*sign(x).*(abs(x)>p);    