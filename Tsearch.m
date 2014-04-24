close all;
clear all;
clc;

%I is the pattern.
I=imread('pattern3.bmp');
%figure; imshow(I);
image=imread('5d.png'); %26 25 24 23 22 17 12 8 7 5 4 3 2 %26 25 24 23 22 13 11 9 8 7 5 4 2 1

%image is the original image. 
%12 17 22 2
%% pattern processing

%RESIZE the original image.

[m,n,k]=size(image);
scale=360/m;
image=imresize(image,scale);
[m1,n1,k]=size(image);

%Gaussian pattern
I=rgb2gray(I);
%I=histeq(I);
I=double(I);
Matrix=(50<I);
I=I.*(double(Matrix));

%flip
[pm,pn]=size(I);
Irev=I;
i=1:pm;
j=1:pn;
Irev(pm+1-i,pn+1-j)=I(i,j);
I=Irev;

%gaussian model
H = fspecial('gaussian',[3 3],2);
I= imfilter(I,H,'same');
ToNormal=sum(sum(I));

% DisPattern=dohough(I, I);

%% begin searching

%patches histogram equlization
% grayimage=histogramm(image);
% 
grayimage=rgb2gray(image); %grayimage is the edged-gray original image
grayimage=edge(grayimage,'sobel','vertical');
% figure; imshow(grayimage);
grayimage=double(grayimage);
J=grayimage;

convres=conv2(J,I,'same');
maxval=max(max(convres));
maxnormval=maxval/ToNormal
[xm,ym]=find(convres==maxval);
selectk=1;

for k=1:-0.02:0.9
    I=imresize(I,k);
    convres=conv2(J,I,'same');
    ToNormal=sum(sum(I));
    val=max(max(convres));
    normval=val/ToNormal;
    [x,y]=find(convres==val);
    if normval>maxnormval
        xm=x;
        ym=y;
        selectk=k;
    end
end

%% box out Bolin

m=floor(selectk*pm); %first search result size
n=floor(selectk*pn);
xm1=floor(xm-m/2);% left up point
ym1=floor(ym-n/2);
% Q = imread('4.jpg');
% 
% figure; imshow(Q);
K = imread('5.png');
figure('units','normalized','outerposition',[0 0 1 1]);subplot(1,2,1); imshow(K);
rectangle('position',[ym1 xm1 n m],'edgecolor','green' );

%% highlight the box area

selmatr=zeros(m1,n1);
for i=xm1:min(xm1+m,m1);
    for j=ym1:min(ym1+n,n1);
        selmatr(i,j)=1;
    end
end

grayimage2=grayimage.*selmatr;
% figure; imshow(grayimage2);

%% hough transformation
DisImage=dohough(grayimage2,image);

ConstScare=85/52;

PP= pm/pn;
n2=floor(DisImage*ConstScare);
m2=floor(PP*n2);
xm2=floor(xm-m2/2);
ym2=floor(ym-n2/2);

subplot(1,2,2); imshow(K);
% figure; imshow(Q);
rectangle('position',[ym2 xm2 n2 m2],'edgecolor','red' );


%---------------------------------------------------------%
%we only do the vertical hough, maybe we can do the horizental hough
%transformation

%---------------------------------------------------------%


