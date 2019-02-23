clear; clc;

rows  = 4;
col = 5;
i = 1;

im = double (imread('zubr.jpg'))/255;
im = rgb2gray(im);

f = ones(7); 
f = f/sum(f(:));
im1 = imfilter(im,f);

f2 = [0,-1,0;-1,5,-1;0,-1,0];
f2 = f2/sum(f2(:));
im2 = imfilter(im,f2);

f3 = [0,1,0;-1,1,-1;0,1,0];
f3 = f3/sum(f3(:));
im3 = imfilter(im,f3);

im4 = medfilt2(im,[5,5]);

bim = im2bw(medfilt2(im),.65);
bim = ~bim; %inwersja bim = 1 - bim

im5 = imerode(bim, ones(5)); % to samo co 2ximerode(im,ones(3))

im6 = imdilate(bim, ones(7));

im7 = imerode(bim, ones(7));
im7 = imdilate(im7, ones(7));

im8 = imopen(bim, ones(7)); %erode + dilate, operacja otwarcia

im9 = imopen(im8, ones(7)); %nic nie zmieni

im10 = imdilate(bim, ones(7));
im10 = imerode(im10, ones(7)); %operacja zamkniecia

im11 = imclose(bim, ones(7));

test = im;   % zostawic kontury zubra
test = imfilter(test,f2);
test = im2bw(medfilt2(test),.65);
test = ~test;
test = imdilate(test, ones(7));
test = imclose(test, ones(7));

im12 = bim - imerode(bim, ones(9));

im13 = imdilate(bim, ones(9)) - bim;

%f4 = [-1,-1,-1;-1,8,-1;-1,-1,-1];
%f4 = f4/sum(f4(:));
%im14 = imfilter(bim,f4);

%f5 = [0,-1,0;-1,4,-1;0,-1,0];
%f5 = f5/sum(f5(:));
%im15 = imfilter(bim,f5);

imc = double (imread('zubr.jpg'))/255;
h = fspecial('sobel');
imc = imfilter(imc, h);

subplot(rows,col,i); i = i + 1; imshow(im);
subplot(rows,col,i); i = i + 1; imshow(im1);
subplot(rows,col,i); i = i + 1; imshow(im2);
subplot(rows,col,i); i = i + 1; imshow(im3);
subplot(rows,col,i); i = i + 1; imshow(im4);
subplot(rows,col,i); i = i + 1; imshow(bim);
subplot(rows,col,i); i = i + 1; imshow(im5);
subplot(rows,col,i); i = i + 1; imshow(im6);
subplot(rows,col,i); i = i + 1; imshow(im7);
subplot(rows,col,i); i = i + 1; imshow(im8);
subplot(rows,col,i); i = i + 1; imshow(im9);
subplot(rows,col,i); i = i + 1; imshow(im10);
subplot(rows,col,i); i = i + 1; imshow(im11);
subplot(rows,col,i); i = i + 1; imshow(test);
subplot(rows,col,i); i = i + 1; imshow(im12);
subplot(rows,col,i); i = i + 1; imshow(im13);
%subplot(rows,col,i); i = i + 1; imshow(im14);
%subplot(rows,col,i); i = i + 1; imshow(im15);
subplot(rows,col,i); i = i + 1; imshow(imc);