% Loads the Image
I = imread('liver.jpg');
I = double(I);

% Defines the Region of Interest

% Creates a Mask
BW = roipoly(I);
BW = double(BW);

BW(BW==0) = NaN;
filter_I = I.*BW;

% Plot 
subplot(1,3,1)
imshow(uint8(I))
subplot(1,3,2)
imshow(uint8(BW))
subplot(1,3,3)
imshow(uint8(filter_I))

% Calculate mean
mean_value = mean(filter_I(~isnan(filter_I)))
imshow(tma2(I,BW,mean_value))
