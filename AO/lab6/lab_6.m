clear;
clc;

im2 = double(imread('ptaki.jpg'))/255;
im = rgb2gray(im2);
%im = im2bw(im, .6);
%imhist(im);

%wyciagamy kolejne kanaly
%{
col = 2;
rows = 3;
i = 1;

subplot(rows,col,i); i = i + 1;
imshow(im(:,:,1));
subplot(rows,col,i); i = i + 1;
imhist(im(:,:,1));

subplot(rows,col,i); i = i + 1;
imshow(im(:,:,2));
subplot(rows,col,i); i = i + 1;
imhist(im(:,:,2));

subplot(rows,col,i); i = i + 1;
imshow(im(:,:,3));
subplot(rows,col,i); i = i + 1;
imhist(im(:,:,3));
%}

%binaryzacja, wyodrebnienie kaczek od tla
r = im2(:,:,1);
g = im2(:,:,2);
b = im2(:,:,3);
r(r< 0.15) = 1;
r = im2bw(r, 0.3);
b = ~im2bw(b,0.6);
bim = r | b;
bim = imopen(bim, ones(7));
%imshow(bim);

l = bwlabel(bim);
N = max(l(:));
a = regionprops(l==3, 'all'); %workspace->openSelection
%area - pole powierzchni w piksleach
%BoundingBox - najmniejszy prostokat w ktorym da sie zamknac obiekt
%Centroid - srodek masy
%imshow(a.Image);

%wspolczynnik malinowskiej Rc/Rb - 1
%Circuralitys = 2Ra
%Circuralityc = 2Rc
%wspolczynnik Fereta F1/F2
%blairBliss srednia odleglosc punktow na obrazie od srodka masy
%Harlic jak dalego znajduje sie piksel od najblizszej krawedzie
%Danielson - odleglosc punktu krawedzi od srodka masy

f = {@AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska, @AO5RShape};
for i = 1:length(f)
    for j = 1:N
        W(i,j) = f{i}(l==j);
    end
end    

m = mean(W,2); %wartosc oczekiwana
s = std(W,0,2); %odchylenie standardowe
%standaryzacja
err = (W - repmat(m,[1,N]))./repmat(s,[1,N]);
kaczki = abs(err) < 2;
czy_kaczka = min(kaczki);
