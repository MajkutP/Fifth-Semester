clear; clc;

rows = 4;
col  = 3;
i = 1;

im = double (imread('zubr.jpg'))/255;
im = rgb2gray(im);

subplot(rows,col,i); i = i + 1;
imshow(im);
subplot(rows,col,i); i = i + 1;
imhist(im);
x = linspace(0,1,256);
y = x;
subplot(rows,col,i); i = i + 1;
plot(x,y);
axis([0,1,0,1]);

%jasnosc - dodawanie
%konstrast - mnozenie
%gamma - potegowanie

%jasnosc
a = 0.2;
im1 = im + a;
im1(im>1)=1;
im1(im1<0)=0;
x = linspace(0,1,256);
y=x+a;
y(y>1)=1;
y(y<0)=0;

subplot(rows,col,i); i = i + 1;
imshow(im1);
subplot(rows,col,i); i = i + 1;
imhist(im1);
subplot(rows,col,i); i = i + 1;
plot(x,y);
axis([0,1,0,1]);

%kontrast
b = 0.2;
im2 = im * b;
im2(im2 > 1) = 1;
im2(im2<0)=0;
x = linspace(0,1,256);
y = x + b;
y(y>1)=1;
y(y<0)=0;

subplot(rows,col,i); i = i + 1;
imshow(im2);
subplot(rows,col,i); i = i + 1;
imhist(im2);
subplot(rows,col,i); i = i + 1;
plot(x,y);
axis([0,1,0,1]);
