% Demo to have the user freehand draw an irregular shape over
% a gray scale image, have it extract only that part to a new image,
% and to calculate the mean intensity value of the image within that shape.
% Also calculates the perimeter, centroid, and center of mass (weighted centroid).
% Change the current folder to the folder of this m-file.
if(~isdeployed)
	cd(fileparts(which(mfilename)));
end
clc;	% Clear command window.
clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.
fontSize = 16;
% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, 'C:\Users\omsriram\Downloads');
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
BW = roipolyold(grayImage);
imshow(BW);
