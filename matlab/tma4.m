clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end
% Read in gray scale demo image.
folder = 'C:\Users\jhilam\Downloads';
baseFileName = 'liver.jpg';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the original gray scale image.
subplot(2, 3, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 
% Blacken the white bar artifact in the left 5 columns.
grayImage(:, 1:5) = 0;
% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 3, 2); 
bar(grayLevels, pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
% Binarize the image to get the body.
binaryImage = grayImage > 150;
% Display the binary image.
subplot(2, 3, 3);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);
% Fill and get rid of small objects
binaryImage2 = imfill(binaryImage, 'holes');
minAcceptableSize = round(rows*columns*0.05);
binaryImage2 = bwareaopen(binaryImage2, minAcceptableSize);
% Display the binary image.
subplot(2, 3, 4);
imshow(binaryImage2, []);
title('Binary Image 2', 'FontSize', fontSize);
% Invert and OR
binaryImage2 = ~(~binaryImage2 | binaryImage);
% Display the binary image.
subplot(2, 3, 5);
imshow(binaryImage2, []);
axis on;
title('Binary Image 2', 'FontSize', fontSize);
% Fill again
binaryImage3 = imfill(binaryImage2, 'holes');
% Get rid of small things again.
binaryImage3 = bwareaopen(binaryImage3, minAcceptableSize);
% And it with binary image 2
binaryImage3 = binaryImage3 & binaryImage2;
% Display the binary image.
subplot(2, 3, 6);
imshow(binaryImage3, []);
title('Binary Image 3', 'FontSize', fontSize);
uiwait(helpdlg('Done with Demo by Image Analyst!'));
