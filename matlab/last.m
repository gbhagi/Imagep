[a, map] = imread('liver.jpg');
G = fspecial('gaussian',[7 15],3.2);
%# Filter it
I= im2double(a);
k = rgb2gray(imread('liver.jpg'));
X = grayslice(k,16);
level = multithresh(I);
uniqLevels = unique(I(:));
imshow(uniqLevels);
disp(['Number of unique levels = ' int2str( length(uniqLevels) )]);
Nvals = [1 2 4 8];
for i = 1:length(Nvals)
    [thresh, metric] = multithresh(I, Nvals(i) );
    disp(['N = ' int2str(Nvals(i)) '  |  metric = ' num2str(metric)]);
end

% 
% Ig = imfilter(a,G,'replicate');
% disp(mean(Ig(:)))    
% mask = (Ig > mean(Ig(:)));
% disp(size(mask));
% maskd = mask + 0.1.* I;
% subplot(1,3,1);
% imshow(.299.*maskd(:,:,1) + .587.*maskd(:,:,2) + .144.*maskd(:,:,3))
% colormap(jet)
% set(gca,'clim',[0 60])
% title('masked');
% subplot(1,3,2);
% % maskd = mask
% % i = rgb2gray(maskd);
% % new_i = .299.*i(:,:,1) + .587.*i(:,:,2) + .144.*i(:,:,3);
% % kk = dot(maskd,[0.299,0.587,0.144])
% imshow(a);
% title('original');
% maskedRgbImage = bsxfun(@times, a, cast(mask, class(rgbImage)));
% subplot(1,2,1);
% imshow(maskedRgbImage);
% title('masked');
% subplot(1,2,2);
% imshow(a);
% title('original');