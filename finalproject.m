close all;
clear;clc;

%I is the pattern.
I=imread('pattern3.bmp');
I=PatternPre(I);
ToNormal=sum(sum(I));
[pm,pn]=size(I);

image=imread('19.jpg'); 
[m,n,k]=size(image);
scale=360/m;
image=imresize(image,scale);
[m1,n1,k]=size(image);
%image is the original image. 

%Totally OK:
%2 3 5 7 22 23
%ace OK:
%4 8 12 13 17 19 20 

%NO: 6 10 14 15 16 18 21

%% begin searching

%patches histogram equalization
grayimage=histogram(image);

% grayimage=VarRefine(image);

%without histogram equalization

% grayimage=rgb2gray(image); %grayimage is the edged-gray original image
% grayimage=edge(grayimage,'sobel','vertical');
% figure;imshow(grayimage);


grayimage=double(grayimage);
J=grayimage;

convres=conv2(J,I,'same');
maxval=max(max(convres));
maxnormval=maxval/ToNormal;
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
% maxnormval
% flag=svmdecide(maxnormval)
%% box out Bolin
% if flag==1
m=floor(selectk*pm); %first search result size
n=floor(selectk*pn);
xm1=floor(xm-m/2);% left up point
ym1=floor(ym-n/2);  
% 
% plus=zeros(m1,n1);
% I=flip(I);
% plus(xm1:xm1+m-1,ym1:ym1+n-1)=imresize(I,[m,n]);
% imageplus=image;
% imageplus(:,:,2)=image(:,:,2)+uint8(plus);
% figure;imshow(imageplus);


figure; imshow(image);
rectangle('position',[ym1 xm1 n m],'edgecolor','green' );

%% highlight the box area

selmatr=zeros(m1,n1);
for i=xm1:min(xm1+m,m1);
    for j=ym1:min(ym1+n,n1);
        selmatr(i,j)=1;
    end
end

grayimage2=grayimage.*selmatr; %selected area
figure; imshow(grayimage2);

%% hough transformation
DisImage=dohough(grayimage2,image);

ConstScare=85/52;

PP= pm/pn;
n2=floor(DisImage*ConstScare);
m2=floor(PP*n2);
xm2=floor(xm-m2/2);
ym2=floor(ym-n2/2);
figure; imshow(image);
rectangle('position',[ym2 xm2 n2 m2],'edgecolor','red' );

% plus=zeros(m1,n1);
% I=flip(I);
% plus(xm2:xm2+m2-1,ym2:ym2+n2-1)=imresize(I,[m2,n2]);
% imageplus=image;
% imageplus(:,:,2)=image(:,:,2)+uint8(plus);
% figure;imshow(imageplus);
% else
%     fprintf('there is no Bolin in the image!\n')
% end

%---------------------------------------------------------%
%we only do the vertical hough, maybe we can do the horizental hough
%transformation

%---------------------------------------------------------%


