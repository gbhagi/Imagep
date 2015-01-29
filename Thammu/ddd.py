import scipy
from scipy import ndimage
import matplotlib.pyplot as plt
import numpy as np


im = scipy.misc.imread('liver.jpg',flatten=10)

l_im = np.searchsorted()
# im, number_of_objects = ndimage.label(im)
# blobs = ndimage.find_objects(im)

# print number_of_objects
plt.imshow(im)
plt.show() 