function [ distance ] = dohough( I , J )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% I is the egded gray original image
% J IS orginal image


[H,T,R] = hough(I,'Theta',-1:1); %T is theta and R is 'rou'
% imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
       
% scaling=50;
% size(H)
% kf=floor(size(H)/scaling);
% sizeN=kf-(1-mod(kf,2))
sizeN=[49,3];

P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))),'NhoodSize',sizeN);
%P is the coordinates of the peak point.
x= T(P(:,2)); 
y = R(P(:,1));

%choose the most separated two lines.
ymin=min(R(P(:,1)));
ymax=max(R(P(:,1)));
distance=ymax-ymin;

% plot(x,y,'s','color','white');
 
% Find lines and plot them
lines = houghlines(I,T,R,P,'MinLength',7,'fillgap',100);
% figure, imshow(J), hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% %  
% % plot beginnings and ends of lines
%     plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
 
% determine the endpoints of the longest line segment 
xy_long=zeros(1,2);
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
 
% highlight the longest line segment
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');




end

