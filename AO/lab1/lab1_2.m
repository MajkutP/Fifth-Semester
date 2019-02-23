clear; clc;

im = imread('index.jpeg');
im = double(im)/255; %normalizacaja
[x,y,z] = size(im); % y = size(im,2);

imshow(im);
imshow(im(:,:,3)); %tylko trzeci kanal 

bim = im;
bim(:,:,[1,2]) = 0; %tylko niebieski
imshow(bim);

gim = mean(im,3); %srednia w trzecim kierunku
imshow(gim);  % w odcieniach szarosci

%dim = max(im,3);
%imshow(dim);

YUV = [.299, .587, .114];
YUV = permute(YUV,[1,3,2]); % 1,3,1 -> 1,1,3 wymiary
YUV = repmat(YUV,[x,y,1]); %powielenie
gim = sum(im.*YUV,3);
imshow(gim);