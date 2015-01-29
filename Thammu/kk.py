import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from scipy import ndimage, misc
import pdb

np.set_printoptions(threshold='nan')
def rgb2gray(rgb):
    print rgb.shape
    return np.dot(rgb[...,:3], [0.299, 0.587, 0.144])

# img = mpimg.imread('C:\Users\omsriram\Documents\MATLAB\liver.jpg')     
img = mpimg.imread('C:\Users\omsriram\Downloads\Thammu\dddd.jpg')     
# img = img.nonzero
img = ndimage.gaussian_filter(img, sigma=256/(4.*20))
print img.mean()
# pdb.set_trace()
mask = (img > img.mean()).astype(np.float)
print mask.shape
mask += 0.1 * img

plt.imshow(img)
plt.show()

# img = mask + 0.1*np.random.randn(*mask.shape)


plt.imshow(mask)
plt.show()

# hist, bin_edges = np.histogram(img, bins=60)
# bin_centers = 0.5*(bin_edges[:-1] + bin_edges[1:])

# binary_img = img > img.mean()
# labels, nb = ndimage.label(mask)


# label_im, nb_labels = ndimage.label(img)		


gray = rgb2gray(mask)    
# print gray
 # Remove small white regions

# l=128
# open_img = ndimage.binary_opening(mask)
# # Remove small black hole
# close_img = ndimage.binary_closing(mask)

# plt.imshow(mask[:l, :l], cmap=plt.cm.gray)
# plt.contour(close_img[:l, :l], [0.5], linewidths=2, colors='r')
# plt.axis('off')
# from skimage import filter

# otsu = filter.threshold_otsu(gray)
# otsu_mask = gray < otsu
# k = ndimage.binary_erosion(gray)
# kk = ndimage.binary_dilation(k)
# k = misc.imread(k,flatten=1)
plt.imsave('kanth.jpg',gray)
plt.imshow(gray)
plt.axis('off')
plt.show()
# plt.imshow(gray, cmap = plt.get_cmap('gray'))w
# plt.show()
