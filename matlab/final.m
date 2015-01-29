%% Instructions Set Followed by Reading Image
 
% *********************************
% Works without Image Processing Toolbox 
% *********************************

% So no need of wild installations and setting up. This is pure matlab
% code. you can use with any CT scan image and check out the results.
% I've tested with few images . I was able to extract the Bones , liver and other organs distinctively.
% Currently this version treats image for subsequent matrix manipulations for pure image enhancement only.
% I urge you to check with multiple Image sets.

% Setting up the image and creating intensity image [maatrix] out of it.
% Intensity matrix is enhansed b/w to color image with distinctive intensity of (gray) color levels 
% You will find these color levels are mapped to actual colors to create the pattern 
 
% ************************************
% The testing is done by hardcoding the dimensions of the given image for creating intensity matrix
% Beware, need to change the values of image dimensions where ever they are necessary.
% ************************************
% 
% Inorder to know the dimesions we can simply read the image and do 
% disp(iminfo(liver))
% or 
% whos liver
% {in the command line}
% assuming liver is the name of the image
% Need to apply dimensions for the handler for creating a intensity matrix

liver = imread('dddd.jpg');
% imagesc(liver);

handler=zeros(546,800); % Change Dimensions here 
n=1:1:546; k=1:1:800; % Change Dimensions here

handler(n,k)=0.2989 * liver(n,k,1) + 0.5870* liver(n,k,2) ...
         + 0.1140 * liver(n,k,3); % creates intensity matrix
  % print a color figure in black and white
  

%% display original for comparison 
% colormap function gives multiple options of creating dynamic color patterns in given image
% Read documentation about it to know more uses of colormap.
% Here we are using bone colormap (there many such options jet is other famous one.)

se = strel('disk',11);
% Set the thereshold value accordignly
can = edge(handler, 'canny');
imshow(can); 
title('Canny Edge Detection');
hold 
eroded = imerode(handler,se);
dialated = imdilate(eroded, se);
% imshow(dialated);
% title('Eroded and dilated and canny edge iMage');
figure1=figure;
imagesc(dialated);
colormap(bone);
colorbar;
set(gca,'YDir','reverse');
% Setting up lighting and effects to enhance the image
daspect([0.5 0.5 1]);
view(0,90);
lighting phong;
material shiny;
h=lightangle(45,60);

%%  figure and cleaning
set(figure1,'Position');
set(figure1,'Color',[0.9 0.9 0.9]);
set(figure1,'OuterPosition');
title('Original C T Scan','FontSize',14);
axis off
axis tight
colormap(jet);
title('Original C T Scan colormap','FontSize',14);

%% display result as 3D surface with phong lighting
figure2=figure;
surf(handler,'FaceColor','texturemap','EdgeColor','none');
% used handler for both the relief and the color intensity to be mapped
colormap(bone);
colorbar;
set(gca,'YDir','reverse');
daspect([0.5 0.5 15]);
view(0,90);
lighting phong;
material shiny;
h=lightangle(45,60);  % sets the position of the specified light
%%  figure and cleaning
set(figure2,'Position');
set(figure2,'Color',[0.9 0.9 0.9]);
set(figure2,'OuterPosition');
title('Render C T Scan','FontSize',14);
axis off
axis tight

%% creates elevation matrix
elev=log2(dialated+1)*10; % creates arbitrary elevation matrix (I did this
   % through trial and error).
   % N.B. The function surf used below, would have
   % taken the variable handler as input for both relief
   % and color, but I like more control that what is
   % afforded with the command daspect alone
%% creates elevation matrix
elev=log2(dialated+1)*10; % creates arbitrary elevation matrix (I did this
   % through trial and error).
   % N.B. The function surf used below, would have
   % taken the variable handler as input for both relief
   % and color, but I like more control that what is
   % afforded with the command daspect alone
%% display result as 3D surface with phong lighting
figure3=figure;
surf(elev,handler,'FaceColor','texturemap','EdgeColor','none');
  % used elev for relief and handler for color intensity to be mapped
  % to heated body colormap
colormap(bone);
colorbar;
set(gca,'YDir','reverse');
daspect([0.5 0.5 1]);
view(0,90);
lighting phong;
material shiny;
h=lightangle(45,60);  % sets the position of the specified light
%%  figure and cleaning
set(figure3,'Position');
set(figure3,'Color',[0.9 0.9 0.9]);
set(figure3,'OuterPosition');
title('Render C T Scan Removing Noise','FontSize',14);
axis off
axis tight
clear n k xray figure1 figure2 figure3;
contour3(dialated);
imshow(handler);
% imcontour(handler);

%% 
% ******************
% Future Course:
% 1. Image segmentation 
% 2. Variable Viewing 
% 3. Processing the Segmented Image.
% 4. Contouring 
% 5. Plotting 3D
% ******************