clear;
% Parameters of the Gaussian filter:
n1=10;sigma1=3;n2=10;sigma2=3;theta=0;
% The amplitude of the noise:
noise=0.1;

[w,map]=gifread('liver1.gif');               
x=ind2gray(w,map);
filter1=d2gauss(n1,sigma1,n2,sigma2,theta);
imshow(filter1);
x_rand=noise*randn(size(x));
y=x+x_rand;
f1=conv2(x,filter1,'same');
rf1=conv2(y,filter1,'same') ;
figure(1);
subplot(2,2,1);imagesc(x);
subplot(2,2,2);imagesc(y);
subplot(2,2,3);imagesc(f1);
subplot(2,2,4);imagesc(rf1);
colormap(gray);