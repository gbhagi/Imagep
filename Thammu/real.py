import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from scipy import ndimage, misc
from skimage import feature
np.set_printoptions(threshold='nan')
def rgb2gray(rgb):
    return np.dot(rgb[...,:3], [0.299, 0.587, 0.144])

img = mpimg.imread('liver.jpg')     

print img.shape
mask = (img > img.mean()).astype(np.float)
mask += 0.1 * img
# img = mask + 0.1*np.random.randn(*mask.shape)

k = ndimage.binary_erosion(img, mask=mask)
kk = ndimage.binary_dilation(img, mask=mask)
im, number_of_objects = ndimage.label(img)
print number_of_objects

	 x,y = enumerate(ndimage.find_objects(im))[0]

edges2 = feature.canny(img, sigma=3)

plt.imshow(edges2)
plt.axis('off')
plt.show()
