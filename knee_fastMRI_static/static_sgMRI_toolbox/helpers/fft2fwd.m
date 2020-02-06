function y = fft2fwd(x, ind)

y = fftshift(fft2((x)));
y = y(ind);

