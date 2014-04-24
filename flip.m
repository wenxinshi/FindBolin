function [ Iout ] = flip( Iin )
%FLIP Summary of this function goes here
%   Detailed explanation goes here
%flip the image
[pm,pn]=size(Iin);
Irev=Iin;
i=1:pm;
j=1:pn;
Irev(pm+1-i,pn+1-j)=Iin(i,j);
Iout=Irev;

end

