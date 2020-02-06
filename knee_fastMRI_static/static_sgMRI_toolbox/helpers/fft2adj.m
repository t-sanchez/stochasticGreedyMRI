function y = fft2adj_rectangular_new(x, ind, m,n)

y = zeros([m n]);

y(ind) = x;
y = (ifft2(fftshift(y)));
