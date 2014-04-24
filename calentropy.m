I = imread('24.png');
I = rgb2gray(I);
K = entropy(I);