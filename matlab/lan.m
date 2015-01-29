grayImage = imread('liver.jpg');
binaryImage = grayImage > 130; % You decide what thresholdValue is
maskedImage = uint8(binaryImage) .* grayImage;


tumor = grayImage < 130;
maskedImagett = uint8(tumor) .* grayImage;

imshow(maskedImage, []);
colormap(autumn(256));

figure,imshow(I),hold on
imshow(grayImage); hold on
h = imshow(tumor)
set(h,'AlphaData',double(~mask(:,:,1)))