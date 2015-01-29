rgb = imread('liver.jpg');
I = rgb2gray(rgb);
% subplot(441);
%# Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[5 5],2);
%# Filter it
Ig = imfilter(I,G,'same');

% get the mean of the image
meangl = mean(Ig)
% masked_image = 0.1.*meangl
% Inew = Ig.*masked_image;

% % Create 3 channel mask
% mask_three = Ig.*repmat(meangl, [1, 1, 3]);
% 
% % Apply Mask
% Ig(~mask_three) = 0.1;
% 
% % Display
% imshow(Ig);

imshow(conv2(Ig,ones(3)/9,'same'))