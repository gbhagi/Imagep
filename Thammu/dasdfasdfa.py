import cv2
import numpy as np

# Execute the program By insatalling Python and OpenCV . Check Google for setting up OpenCV for Python.


def thresh_callback(thresh=40):
	# Here we will be taking the Blur image after the Median Blur process and Set some threshold to it 
	edges = cv2.Canny(blur,thresh,thresh*2)
	drawing = np.zeros(img.shape,np.uint8) # Image to draw the contours
	# Contour is process of Highlighting the edges that found for a given threshold. Since there will be many edges we use a loop to point all all the 
	# Contour in one image 
	contours,hierarchy = cv2.findContours(edges,cv2.RETR_TREE,cv2.CHAIN_APPROX_NONE)
	for cnt in contours:
		# color = np.random.randint(0,255,(3)).tolist() # Select a random color for every Edge Uncomment this line to make your Edges Full of colors.[Not Recommended]
		cv2.drawContours(drawing,[cnt],0,(0,255,0),2) # For now i've taken a single Color to Highlight the Contour [Green Color]
		cv2.imshow('output',drawing) # Getting the Countour as a separate image.
	cv2.imshow('input',img) # Showing the original image for Reference.
	# cv2.imshow('superimposed', )

#---------------------------
#                     |
# Program Stars here  |
#                     |
#                     *
# Method 1
#---------------------------

# Take the image; Change the Name if Necessary.
img = cv2.imread('liver.jpg')
# Convert the image to Black and white
gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
# Equalize the Histogram which helps in distinguishing the black and white spots distintivly
equ = cv2.equalizeHist(gray) # Remember histogram equalization works only for grayscale images : 
# To view the Histogram Equalized image Uncomment the below lines , I;ve shown all the images just execute the program
# cv2.imshow("Equalized Histogram",equ)
# cv2.waitKey()

# Here we are applying 3 Major steps to process the image. For that we need to take a Kernel (some thing like a brush)
# Which does these jobs of erosion (removing or thining the gaps ) and dialation (thickening or spreading the gaps) [for our understanding]
# I've taken kernal of 20,20 , feel free to change :)
kernel = np.ones((20,20),np.uint8)

# Dialate the image to remove the small black dots on equalized hist so that unwanted noise is removed
dilation = cv2.dilate(equ,kernel,iterations = 1)
# Apply erosion using the same kernal to Dilated image for Highlighting the large greyed out or blackened Area. Which is Tumor in this case.
erosion = cv2.erode(dilation,kernel,iterations = 1)

# Here we can apply 3 Kinds of blur for smoothening the image. As the image after the Erosion of Dilated image will be filled with Blocks of the kernal Size
# Inorder to remove the pixaled kernal on the image we perform smootheing the image for regaining the original form. By this we complete Removing the noise.
# One is Gaussian Blur, Normal Blur and other is Median Blur. In this case After many trials i've realized Median Blur is Better suited rather than Gaussioan 
# as Gaussian highly depends on the sigma input which must be changed per image basis to get the exact out put we desire.

# Feel free to test all the cases :) by uncommenting below line (Try with any one of them )

# g_blur = cv2.GaussianBlur(erosion,(5,5),0)
# blur = cv2.blur(g_blur,(5,5))
blur = cv2.medianBlur(erosion,5)

# A brief Viewing of the source images and processed image
cv2.imshow('Source Image',img)
cv2.imshow('Histogram Equalized',equ)
cv2.imshow('blurred',blur)
cv2.waitKey(0)
cv2.destroyAllWindows()

# Here we enter the main concept of grabbing the Tumor. 
# We will be using Canny Edge detection. But for "Canny" to work we need to set some threshold
# Threshold is nothing but a Value {array of values} which will determine edges.
# Since the Threshold Determines the Edges and Its higly Unlikely that each image is same as the next I've Put a Threshold Bar Where in you 
# can change the value and determine the edges of the contour. I recommend to test this with various Images and check 
# The Fuction is just a mapper to adjust the Threshold 
cv2.namedWindow('input',cv2.WINDOW_AUTOSIZE)
thresh = 100
max_thresh = 255
cv2.createTrackbar('canny thresh:','input',thresh,max_thresh,thresh_callback)
thresh_callback(thresh)
if cv2.waitKey(0) == 27:
	cv2.destroyAllWindows()



# Method 2

# This is for validation only.. Not for Demostration. Sonta telivi kinda.
# This the 2nd method where in i've declared Upper and lower limit of the color range 
# Of the Tumor. Then abstracted the image out the original image. Now we can apply various shapes
# on it and superimpose that image on the Original. 
boundaries = [([103, 86, 65], [145, 133, 128])]
for (lower, upper) in boundaries:

	lower = np.array(lower, dtype = "uint8")
	upper = np.array(upper, dtype = "uint8")
	 
	# find the colors within the specified boundaries and apply
	# the mask
	mask = cv2.inRange(img, lower, upper)
	output = cv2.bitwise_and(img, img, mask = mask)
	# show the images
	cv2.imshow("BruteForce For Checking", np.hstack([img, output]))
	cv2.waitKey(0)