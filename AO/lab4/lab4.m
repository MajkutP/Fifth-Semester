clear; clc;

rows = 3;
col = 3;
i = 1;

im = double (imread('opera.jpg'))/255;
im = rgb2gray(im);
subplot(rows,col,i); i = i + 1; imshow(im);

fim = fft2(im); %szybka transformata Fouriera
subplot(rows,col,i); i = i + 1; imshow(fim);

A = abs(fim);       %r = re(fim);
phi = angle(fim);   %i = im(fim);
subplot(rows,col,i); i = i + 1; imshow(phi, [-pi, pi]);

lA = log(A+1);
subplot(rows,col,i); i = i + 1; imshow(lA, [0, max(lA(:))]);

Aa = fftshift(A);
lA = log(Aa+1);
subplot(rows,col,i); i = i + 1; imshow(lA, [0, max(lA(:))]);

phi(200,200) = ~phi(200,200);
subplot(rows,col,i); i = i + 1; imshow(phi, [-pi, pi]);

%A(100,100) = 10^5;

A = fftshift(A);
A([1:100,end-100:end],:)=0;  %wycinanie tej czesci widma amplitudowego
A(:,[1:100,end-100:end])=0;  %ktora nic nie wnosila, otrzymujemy "to samo"
A = fftshift(A);   

%zastosowanie: przy kompresji, zachowujemu wazne informacje

fim = A.*exp(1i*phi);
iffim = abs(ifft2(fim));
subplot(rows,col,i); i = i + 1; imshow(iffim);

[h,w,z] = size(im);
filt = fspecial('gaussian',[h,w], 5); % 5 - odchylenie
filt = fft2(filt);
fA = abs(filt);
pA = angle(filt);
lfA = log(fA + 1);
ni = fftshift(pA);
nt = A.*fA;
fim = nt.*exp(1i.*phi);
nt = abs(ifft2(fim));
subplot(rows,col,i); i = i + 1; imshow(nt);


