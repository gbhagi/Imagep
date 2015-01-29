import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('liver.jpg',0)
edges = cv2.Canny(img,100,200)

# kk = cv2.watershed(img)


ret,thresh = cv2.threshold(img,127,255,0)
contours,hierarchy = cv2.findContours(thresh, cv2.RETR_TREE,cv2.CHAIN_APPROX_NONE)
# print hierarchy
cnt = contours[4]

# print hierarchy
x,y,w,h = cv2.boundingRect(cnt)
# img = cv2.rectangle(img,(x,y),(x+w,y+h),(0,255,0),2)

M = cv2.moments(cnt)
# print M
x,y,w,h = cv2.boundingRect(cnt)
# print x,y,w,h
# img1 = cv2.drawContours(img,(x,y),(x+w,y+h),(0,255,0),3)

cv2.drawContours(img, contours, 55, (0,255,0), 3)
# print type(img1)
cv2.imshow("contour",img)
cv2.waitKey()

# plt.subplot(121),plt.imshow(img1,cmap = 'gray')
# plt.title('Original Image'), plt.xticks([]), plt.yticks([])
# plt.subplot(122),plt.imshow(edges,cmap = 'gray')
# plt.title('Edge Image'), plt.xticks([]), plt.yticks([])

# plt.show()

