clear;
clc;

im = double(imread('kaczki.jpg'))/255;
im = rgb2gray(im);
%imshow(im);

im = ~im2bw(im, .6);
%imshow(im);

im = imclose(im, ones(7));
%imshow(im);

%imshow(bwmorph(im,'skel', inf));
%imshow(bwmorph(im,'thicken', inf));
%imshow(bwmorph(im,'shrink', inf));
%imshow(bwmorph(im,'thin', inf));
%imshow(bwmorph(im,'majority', 1));
%imshow(bwmorph(im,'remove',inf ));

l = bwlabel(im);
%imshow(l,[0,max(l(:))]);

l2 = label2rgb(l); %nadaje kolory zamiast numerow(etykiet)
%imshow(l2);

%imshow(l == 2); %tylko jedna kaczka

imc = double(imread('kaczki.jpg'))/255; %jedna kaczka w kolorze
%imshow(imc.*repmat((l==2),[1,1,3]));

im2 = bwmorph(im,'thicken', inf);
ll= bwlabel(im2);
%imshow(imc.*repmat((ll==3),[1,1,3])); %wyrozniamy jedna kaczke

d = bwdist(~im);  %transformata odleglosciowa
%imshow(d,[0,max(d(:))]);
  
im([1,end],:) = 1;  %dodanie ramki, zwiększa przejrzystosc
im(:,[1,end]) = 1;
d = bwdist(im);
%imshow(d,[0,max(d(:))]);

l = watershed(d);    %transforamcja wododzialowa, tez nadaje etykiety                                                   
imshow(l,[0,max(l(:))]);
%metryki euklides, manhatan, czebyszew 