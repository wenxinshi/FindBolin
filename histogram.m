function [ back ] = histogram( I )
% close all; 
% clear all;
% clc;
% I = imread('4.jpg');
I = rgb2gray(I);
figure,imshow(I);title('gray image');
[m n] = size(I);
x = 4;
y = 4;

m1 = floor(m/x);
n1 = floor(n/y);
back = zeros(size(I));

Z = I(1:m1*x,1:n1*y);
I = Z;

J=zeros(m1*x,n1*y);

%Jedge=J;
for i=1:1:m1;
    for j=1:1:n1;
%         
%         J((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y)=I((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y);
%         J((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y)=histeq(I((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y));    
        %Jedge((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y)=edge(J((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y),'sobel','vertical');
               Var = variance(I((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y);
               if Var >= 10
                  J((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y) = 0;
               else
                J((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y)=I((i-1)*x+1:1:i*x,(j-1)*y+1:1:j*y);
 
    end
end
Jedge=edge(J,'sobel','vertical');
Jo=edge(I,'sobel','vertical');
Jedge=uint8(Jedge);
Jo=uint8(Jo);

% figure,imshow(Jedge,[]);title('Eq');
% figure,imshow(uint8(J),[]);
%  figure,imshow(Jo,[]);title('Original edge');
%  figure,imshow(Jedge-Jo,[]);title('Diff');
% for i=0:1:m1-1;
%     for j=0:1:n1-1;
%         rectangle('position',[1+j*y 1+i*x y x],'edgecolor','green' );
%     end
% end
back(1:m1*x,1:n1*y)=Jedge-Jo;
figure,imshow(back);


end

