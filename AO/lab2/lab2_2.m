clear; clc;

rows = 3;
col  = 3;
i = 1;

im1 = double (imread('zubr.jpg'))/255;
im2 = double (imread('index.jpeg'))/255;

[h,w,d] = size(im1);
im2 = imresize(im2, [h,w]);

im3 = (im1 + im2)/2;
k = .2;
im4 = k*im1 + (1-k)*im2;

subplot(rows,col,i); i = i + 1;
imshow(im1);
subplot(rows,col,i); i = i + 1;
imshow(im2);
subplot(rows,col,i); i = i + 1;
imshow(im3);
subplot(rows,col,i); i = i + 1;
imshow(im4);

m = linspace(0,1,w);
m = repmat(m,[h,1,3]);
im5 = im1 .*m;

subplot(rows,col,i); i = i + 1;
imshow(im5);