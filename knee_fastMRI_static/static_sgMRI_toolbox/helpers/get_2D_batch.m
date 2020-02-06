function [im_tot,k_tot,batch_tot] = get_2D_batch(b,folder, data_size)
%get_2D_batch_train: given a batch size b and a folder (containing 3D .h5 images),
% returns a batch of size b 2D data from it. The images are cropped to
% size.
% 
% The data read originate from the fastMRI knee dataset [1] and are .h5
% files with 3D complex data, selecting a single slice at random.
%
% [1] Zbontar, J., et al. "fastMRI: An open dataset and benchmarks for 
% accelerated MRI." arXiv preprint arXiv:1811.08839 (2018).
%
% Thomas Sanchez - 2020

    x_size = data_size(1); y_size = data_size(2);
    
    f = dir(folder);
    batch = datasample(3:numel(f),b,'Replace',true);
    batch_tot = zeros([b,2]);
    batch_tot(:,1) = batch;
    im_tot = zeros(x_size,y_size,b);
    k_tot = zeros(x_size,y_size,b);
    
    for idx = 1:b
       file_loc = strcat(f(batch(idx)).folder,'/',f(batch(idx)).name);
       
       % Select the slice at random from the 12 center-most slices.
       slice = randi([12,24],1);  
       batch_tot(idx,2) = slice;
       
       % Read the k-space data
       kdata = h5read(file_loc,'/kspace');
       kdata = kdata.r + 1i.*kdata.i;
       kdata = kdata(:,:,slice);
       
       [nx,ny] = size(kdata);
       im = fftshift(ifft2(fftshift(kdata)));
       
       % Crop to 320 x 320 images.
       im = im(nx/2-x_size/2+1:nx/2+x_size/2,ny/2-y_size/2+1:ny/2+y_size/2);
       im = im./max(abs(im(:))); % Normalize the magnitude image to 0-1
       
       im_tot(:,:,idx) = im;
       k_tot(:,:,idx) = fft2(im);
    end
end

