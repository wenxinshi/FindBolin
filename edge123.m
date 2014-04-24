I = imread('2.jpeg');
I = rgb2gray(I);
A = edge(I,'zerocross'); 
imshow(A);