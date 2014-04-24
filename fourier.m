I = imread('6.jpg');
J = fft2(I);
M = abs(J) < 1000;
N = ifft2(M);
imshow(N,[])
