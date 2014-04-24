function [ I2 ] = PatternPre( I1 )
%Gaussian processing and Flip

%Gaussian pattern
I=rgb2gray(I1); 
I=double(I);
Matrix=(50<I);
I=I.*(double(Matrix));

%flip
I=flip(I);

%gaussian model
H = fspecial('gaussian',[3 3],2);
I2= imfilter(I,H,'same');

end

