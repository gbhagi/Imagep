# Imagep
# Image processing with matlab


- Tried to do without using any external toolkit. 
- except for dialation and erosion. 

- Not applied any gauss filters
- not applied any canny edge detection
- Plotted 3D graph of contours.


# Image Processing with Python

- Used OpenCV
- Dialated source Image
- Eroded dialated Image
- Performed Median Blur
- Performed Canny edge detection

```
cv2.namedWindow('input',cv2.WINDOW_AUTOSIZE)
thresh = 100
max_thresh = 255
cv2.createTrackbar('canny thresh:','input',thresh,max_thresh,thresh_callback)
thresh_callback(thresh)
if cv2.waitKey(0) == 27:
	cv2.destroyAllWindows()

```

# Future scope

- Nuclie Transform
- Watershed 
- Region Based Pixel redenring
- Blood vessel detection







