clear; clc;

im = double(imread('ptaki2.jpg'))/255;
im = rgb2gray(im);
im = ~im2bw(im, .55);
im = imclose(im, ones(5));
%imshow(im);

l = bwlabel(im);    
for i=1 : max(l(:))
    if length(l(l==i))<1000
        im(l==i) = 0;
    end;
end;

%imshow(im);
l = bwlabel(im);

f = {@AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska, @AO5RShape};

for i=1:max(l(:))
    W2(1,i) = AO5RBlairBliss(l==i);
    W2(2,i) = AO5RCircularityL(l==i);
    W2(3,i) = AO5RCircularityS(l==i);
    W2(4,i) = AO5RDanielsson(l==i);
    W2(5,i) = AO5RFeret(l==i);
    W2(6,i) = AO5RHaralick(l==i);
    W2(7,i) = AO5RMalinowska(l==i);
    W2(8,i) = AO5RShape(l==i);
end 

%------------
im1 = double(imread('ptaki.jpg'))/255;
%im1 = rgb2gray(im1);
%im1 = ~im2bw(im1, .55);
%im1 = imclose(im1, ones(5));

r = im1(:,:,1);
b = im1(:,:,3);
r(r< 0.15) = 1;
r = im2bw(r, 0.3);
b = ~im2bw(b, 0.6);
bim = r | b;
bim = imopen(bim, ones(7));

l1 = bwlabel(bim);
N = max(l1(:));
%imshow(bim);

f = {@AO5RBlairBliss, @AO5RCircularityL, @AO5RCircularityS, @AO5RDanielsson, @AO5RFeret, @AO5RHaralick, @AO5RMalinowska, @AO5RShape};
for i = 1:length(f)
    for j = 1:N
        W1(i,j) = f{i}(l1==j);
    end
end 

%------------
im2 = double(imread('kaczki.jpg'))/255;
im2 = rgb2gray(im2);
im2 = ~im2bw(im2, .55);
im2 = imclose(im2, ones(5));
l2 = bwlabel(im2);

for i=1:max(l2(:))
    W3(1,i) = AO5RBlairBliss(l==i);
    W3(2,i) = AO5RCircularityL(l==i);
    W3(3,i) = AO5RCircularityS(l==i);
    W3(4,i) = AO5RDanielsson(l==i);
    W3(5,i) = AO5RFeret(l==i);
    W3(6,i) = AO5RHaralick(l==i);
    W3(7,i) = AO5RMalinowska(l==i);
    W3(8,i) = AO5RShape(l==i);
end 

N1 = size(W1,2);
N2 = size(W2,2);
N3 = size(W3,2);

trainset = [W1(:,1:end-2), W2(:,1:end-2)];
trainout = [ones(1,N1-2), zeros(1,N2-2)];
testset = [W3, W1(:, end-1:end),W2(:, end-1:end)];
testout = [ones(1,N3), [1,1], [0,0]];

nn = feedforwardnet;
nn = train(nn, trainset, trainout);
res = nn(testset);
round(res) == testout

%sprawozdanie II
%1. operacje morfologiczne, segmantacje
%   szkieletyzacja (wybieramy te punkty ktore sa tak samo odlegle od
%   krawedzi)
%   pogrubienie
%   segmentacja wododzialowa, odleglosciowa
%2. Wspolczynniki geometryczne, binaryzacja z wykorzystaniem gornych
%   kanalow, (wpsilczyniiki: niezalezne od sklai, wymiarow, zwykle porownujemy
%   do kola, patrzymy jak obiekt jets bardzo podobny do kola)
%3. Klasyfikacja obiektow (mamy zbior, patrzymy na podstawie parametrow
%   czym jest dany obiekt)