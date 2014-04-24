I = imread('10.jpg');
I = rgb2gray(I);
J = entropyfilt(I);

imshow(I);
imshow(J,[]);