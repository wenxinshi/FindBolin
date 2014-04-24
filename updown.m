close all;
clear;clc;

I=imread('pattern3.bmp');
[m,n]=size(I);
Irev=I;

i=1:m;
j=1:n;
Irev(m+1-i,n+1-j)=I(i,j);

figure;
subplot(1,2,1); imshow(uint8(Irev)); title('flipped')
subplot(1,2,2); imshow(uint8(I)); title('original')